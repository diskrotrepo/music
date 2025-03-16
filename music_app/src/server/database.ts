import Database from "better-sqlite3";
import { initMigration } from "./migration/initial_migration";

export const db = Database("diskrot.db");
db.pragma("journal_mode = WAL");

export enum DatabaseChangeSetStatus {
    COMPLETE,
    FAILED
}

export interface DatabaseChangeSetDefinition {
    id: string
    title: string
    description: string
    status?: DatabaseChangeSetStatus
    changeSet: Array<DatabaseChangeSet>
}

export interface DatabaseChangeSet {
    sql: string
    params?: any
}

export class DatabaseMigration {

    execute(changeSetDefinition: DatabaseChangeSetDefinition): void {

        const migrationCheck = `
            SELECT count(*) as migration_status FROM migration WHERE id = ? AND status = ?
        `;

        const result: { migration_status: number } = db.prepare(migrationCheck).get(
            [changeSetDefinition.id,
            DatabaseChangeSetStatus.COMPLETE
            ]
        ) as { migration_status: number };


        if (result.migration_status > 0) {
            console.log(`Migration with id "${changeSetDefinition.id}" already applied.`);
            return;
        }

        changeSetDefinition.changeSet.forEach((databaseChangeSet) => {

            if (databaseChangeSet.params == null) {
                db.exec(databaseChangeSet.sql);
            } else {
                db.prepare(databaseChangeSet.sql).run(...databaseChangeSet.params);
            }
        });

        const migrationExecuted = `
            INSERT INTO migration (id, title, description, status) VALUES (?,?,?,?)
        `

        db.prepare(migrationExecuted).run([
            changeSetDefinition.id,
            changeSetDefinition.title,
            changeSetDefinition.description,
            DatabaseChangeSetStatus.COMPLETE
        ]);

        console.log(`Applied migration "${changeSetDefinition.title}"`);
    }


}

export function initDatabase(): void {

    const dataMigration = new DatabaseMigration();

    const createMigration = `
    CREATE TABLE IF NOT EXISTS migration (
      id VARCHAR(36) PRIMARY KEY,
      dt_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      title VARCHAR(256) NOT NULL DEFAULT '',
      description VARCHAR(256) NOT NULL DEFAULT '',
      status VARCHAR(36) NOT NULL DEFAULT 'SUCCESS'
    );
  `;
    db.exec(createMigration);

    dataMigration.execute(initMigration())
}
