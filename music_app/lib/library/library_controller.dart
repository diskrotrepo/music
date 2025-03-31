import 'package:flutter/material.dart';
import 'package:music_app/library/library_repository.dart';
import 'package:logger/logger.dart';
import 'package:music_app/dependency_context.dart';

class LibraryController extends ChangeNotifier {
  LibraryController({
    required this.libraryRepository,
  });
  final LibraryRepository libraryRepository;
  final Logger _logger = di.get<Logger>();

  /*
  public getLibrary(req: Request, res: Response): void {
        // #swagger.tags = ['Library']
        const listView = req.query.list_view as string;
        const favoriteFilter = req.query.favorite as string | undefined;

        if (listView !== "library" && listView !== "trash") {
            res.status(400).json({ error: "Invalid list_view. Must be 'library' or 'trash'" });
            return;
        }

        const isDeleted = listView === "trash" ? 1 : 0;

        let query = `SELECT * FROM music WHERE is_deleted = ?`;
        const params: any[] = [isDeleted];

        if (favoriteFilter !== undefined) {
            query += " AND is_favorite = ?";
            params.push(1);
        }

        const songs: Song[] = db.prepare(query).all(...params) as Song[];

        if (songs.length === 0) {
            res.status(404).json({ error: "No songs found" });
            return;
        }

        const library_list = songs.map((song: Song) => ({
            id: song.id,
            title: song.title,
            filename: song.filename,
            dt_created: song.dt_created ? new Date(song.dt_created).toISOString() : null,
            lyrics: song.lyrics,
            duration: song.duration,
            tags: song.tags,
            negative_tags: song.negative_tags ?? null,
            lrc_id: song.lrc_id ?? null,
            is_favorite: song.is_favorite,
            is_deleted: song.is_deleted,
            processing_status: song.processing_status
        }));

        res.status(200).json({ library: library_list });
    }

    public performAction(req: Request, res: Response): void {
        const { songId, action } = req.body;
        console.info(songId);

        const song: Song | undefined = db
            .prepare(`SELECT * FROM music WHERE id = ?`)
            .get(String(songId)) as Song | undefined;

        if (!song) {
            res.status(404).json({ error: "Song not found" });
            return;
        }

        let updateQuery: string;
        switch (action) {
            case SongAction.FAVORITE:
                updateQuery = `UPDATE music SET is_favorite = 1 WHERE id = ?`;
                break;
            case SongAction.UNFAVORITE:
                updateQuery = `UPDATE music SET is_favorite = 0 WHERE id = ?`;
                break;
            case SongAction.DELETE:
                updateQuery = `UPDATE music SET is_deleted = 1 WHERE id = ?`;
                break;
            case SongAction.RESTORE:
                updateQuery = `UPDATE music SET is_deleted = 0 WHERE id = ?`;
                break;
            default:
                res.status(400).json({ error: "Invalid action" });
                return;
        }

        db.prepare(updateQuery).run(String(songId));

        res.status(200).json({ success: true });
    }
    */
}
