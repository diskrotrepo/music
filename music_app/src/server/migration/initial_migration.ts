import { Database } from "better-sqlite3";
import { DatabaseChangeSet, DatabaseChangeSetDefinition } from "../database";
import { v4 as uuid } from "uuid";

export function initMigration(): DatabaseChangeSetDefinition {

    return {
        id: "initial-setup",
        title: "initial setup",
        description: "This setups our database for the first time.",
        status: undefined,
        changeSet: [
            {
                sql: `
CREATE TABLE IF NOT EXISTS music (
      id VARCHAR(36) PRIMARY KEY,
      filename VARCHAR(255) NOT NULL DEFAULT '',
      title VARCHAR(255) NOT NULL DEFAULT '',
      lyrics VARCHAR(3000),
      tags VARCHAR(2048) NOT NULL DEFAULT '',
      negative_tags VARCHAR(2048),
      input_file VARCHAR(2048),
      model VARCHAR(128) NOT NULL DEFAULT '',
      steps INTEGER NOT NULL DEFAULT 0,
      cfg_strength REAL NOT NULL DEFAULT 0,
      duration INTEGER NOT NULL DEFAULT 0,
      dt_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      is_favorite BOOLEAN NOT NULL DEFAULT false,
      is_deleted BOOLEAN NOT NULL DEFAULT false,
      inference_server VARCHAR(256) NOT NULL DEFAULT '',
      lrc_prompt VARCHAR(2048) NOT NULL DEFAULT '',
      lrc_model VARCHAR(256) NOT NULL DEFAULT '',
      processing_status VARCHAR(36) NOT NULL DEFAULT 'NEW'
);`

            },
            {
                sql: `
CREATE TABLE IF NOT EXISTS prompt (
      id VARCHAR(36) PRIMARY KEY,
      prompt VARCHAR(2048) NOT NULL DEFAULT '',
      category VARCHAR(36) NOT NULL,
      model VARCHAR(128) NOT NULL DEFAULT '',
      is_default BOOLEAN NOT NULL DEFAULT false,
      dt_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
                `
            },
            {
                sql: `
INSERT INTO prompt (id, prompt, category, model, is_default, dt_created) VALUES (?, ?, ?, ?, ?, ?);
                `,
                params: [
                    uuid(),
                    "Take the input, and produce an Simple LRC format file which takes into account time required to sing the previous line. \n            Time tags have the format [mm:ss.xx]lyric , where mm is minutes, ss is seconds, xx is hundredths of a second, \n            and lyric is the lyric to be played at that time. Do not provide any other information. I require just the file.\n\n            Example output:\n\n            [00:12.00]Line 1 lyrics\n            [00:17.20]Line 2 lyrics",
                    "LRC",
                    "default",
                    1,
                    new Date().toISOString(),
                ]
            },
            {
                sql: `
INSERT INTO prompt (id, prompt, category, model, is_default, dt_created) VALUES (?, ?, ?, ?, ?, ?);
                `,
                params: [
                    uuid(),
                    "Take this idea and turn it into a song.",
                    "POET",
                    "default",
                    1,
                    new Date().toISOString(),
                ]
            }
        ]
    }
}
