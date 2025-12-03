package aiwa.entity;

public class Anime {

	private int animeid;
	private String animename;
	private String genre;
	private String image;
	private String link;

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public int getAnimeid() {
		return animeid;
	}

	public void setAnimeid(int animeid) {
		this.animeid = animeid;
	}

	public String getAnimename() {
		return animename;
	}

	public void setAnimename(String animename) {
		this.animename = animename;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}
