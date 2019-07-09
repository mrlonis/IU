import twitter4j.Twitter;
import twitter4j.TwitterFactory;

public interface Constants {
	public static final String HASHTAG = "#C343Rocks";
	public static final int PAGE_SIZE = 20;
	public static final String PUNCTUATION = ".,'?!:;\"(){}^{}<>-";
	public static final String BORING_WORDS = "boringWords.txt";
	
	// Assume alphabet consists of the basic ASCII code.
	public static final int SIGMA_SIZE = 128;
	
	// The factory instance is re-useable and thread safe.
	public static Twitter TWITTER = TwitterFactory.getSingleton();
}
