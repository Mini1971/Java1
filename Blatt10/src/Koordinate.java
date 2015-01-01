import java.io.IOException;

public class Koordinate {
	private double breite;
	private double laenge;

	public Koordinate(double breite, double laenge) {
		this.breite = breite;
		this.laenge = laenge;
	}

	public Koordinate(int bg, int bm, int bs, int lg, int lm, int ls) {
		breite = convert(bg, bm, bs);
		laenge = convert(lg, lm, ls);
	}

	private double convert(int bg, int bm,  int bs) {
		return bg + bm / 60.0 + bs / 3600.0;
	}

	private int[] c2b(double x) {
		int[] erg = new int[3];
	
		erg[0] = (int)x;// Grad
		double tmp = Math.abs((x - erg[0]) * 60);
		erg[1] = (int)tmp;// Minuten
		erg[2] = (int)((tmp - erg[1]) * 60); // Sekunden
	
		return erg;
	}

	@Override
	public String toString() {
		String erg = breite + ", " + laenge + "\n";
		int tmp[] = c2b(breite);
		erg += String.format("%d %d' %d'' ", tmp[0], tmp[1], tmp[2]);
		tmp = c2b(laenge);
		erg += String.format("%d %d' %d'' ", tmp[0], tmp[1], tmp[2]);
	
		return erg;
	}
	
	public void show() {
		try {
			String iexplore = "\"c:\\Program Files\\Internet Explorer\\iexplore.exe\"";
			String url = "http://maps.google.de/maps?q=" + breite + "," + laenge;
			Runtime.getRuntime().exec( iexplore + " " + url);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
