package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Music;

public class MusicModel {

    public ArrayList<Music> search(ServletContext context, 
                                   String word, 
                                   String lang, 
                                   String genre, 
                                   String sort) {

        ArrayList<Music> result = new ArrayList<>();

        try {
            Class.forName("org.sqlite.JDBC");

            Connection conn = DriverManager.getConnection(
                "jdbc:sqlite:" + context.getRealPath("WEB-INF/musics.db")
            );

            // ---------------------------
            // 1) Base SQL
            // ---------------------------
            StringBuilder sql = new StringBuilder(
                "SELECT * FROM musics WHERE 1=1 "
            );

            // ---------------------------
            // 2) Keyword search (name OR artist)
            // ---------------------------
            if (word != null && !word.isEmpty()) {
                sql.append(" AND (name LIKE ? OR artist LIKE ?) ");
            }

            // ---------------------------
            // 3) Language filter
            // ---------------------------
            if (lang != null && !lang.isEmpty()) {
                sql.append(" AND language = ? ");
            }

            // ---------------------------
            // 4) Genre filter
            // ---------------------------
            if (genre != null && !genre.isEmpty()) {
                sql.append(" AND genre = ? ");
            }

            // ---------------------------
            // 5) Sort options
            // ---------------------------
            if (sort != null) {
                switch (sort) {
                    case "name":
                        sql.append(" ORDER BY name COLLATE NOCASE ASC ");
                        break;
                    case "artist":
                        sql.append(" ORDER BY artist COLLATE NOCASE ASC ");
                        break;
                    case "newest":
                        sql.append(" ORDER BY created_at DESC ");
                        break;
                    default:
                        sql.append(" ORDER BY id ASC ");
                        break;
                }
            } else {
                sql.append(" ORDER BY id ASC ");
            }

            PreparedStatement stmt = conn.prepareStatement(sql.toString());

            // ---------------------------
            // 6) Bind parameters dynamically
            // ---------------------------
            int index = 1;

            if (word != null && !word.isEmpty()) {
                stmt.setString(index++, "%" + word + "%");
                stmt.setString(index++, "%" + word + "%");
            }

            if (lang != null && !lang.isEmpty()) {
                stmt.setString(index++, lang);
            }

            if (genre != null && !genre.isEmpty()) {
                stmt.setString(index++, genre);
            }

            // ---------------------------
            // 7) Execute
            // ---------------------------
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Music m = new Music();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setArtist(rs.getString("artist"));
                m.setMusic_url(rs.getString("music_url"));
                m.setGenre(rs.getString("genre"));
                m.setLanguage(rs.getString("language"));
                m.setCreated_at(rs.getInt("created_at"));
                result.add(m);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
