package aiwa.entity;

public class Music {

    private int id;
    private String name;
    private String artist;
    private String music_url;
    private String genre;
    private String language;
    private int created_at;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getArtist() {
        return artist;
    }
    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getMusic_url() {
        return music_url;
    }
    public void setMusic_url(String music_url) {
        this.music_url = music_url;
    }

    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language;
    }

    public int getCreated_at() {
        return created_at;
    }
    public void setCreated_at(int created_at) {
        this.created_at = created_at;
    }
}
