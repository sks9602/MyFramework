package project.jun.was.listener;

import org.apache.commons.fileupload.ProgressListener;
import org.apache.log4j.Logger;

public class HoFileUploadProgressListener implements ProgressListener {

	protected  Logger          logger     = Logger.getLogger(HoFileUploadProgressListener.class);

	private long num100Ks = 0;

	private long bytesRead = 0;
	private long contentLength = -1;
	private int whichItem = 0;
	private int percentDone = 0;
	private boolean contentLengthKnown = false;
	
	@Override
	public void update(long bytesRead, long contentLength, int items) {

		if (contentLength > -1) {
			contentLengthKnown = true;
		}
		this.bytesRead = bytesRead;
		this.contentLength = contentLength;
		whichItem = items;

		logger.debug(" items : " + items );
		logger.debug(" bytesRead : " + bytesRead );
		logger.debug(" contentLength : " + contentLength );

		long nowNum100Ks = bytesRead / 100000;
		// Only run this code once every 100K
		if (nowNum100Ks > num100Ks) {
			num100Ks = nowNum100Ks;
			if (contentLengthKnown) {
				percentDone = (int) Math.round(100.00 * bytesRead / contentLength);
			}
			logger.debug(getMessage());
		}
		if( bytesRead>= contentLength) {
			percentDone = 100;
		}
	}

	public String getMessage() {
		if (contentLength == -1) {
			return "" + bytesRead + " of Unknown-Total bytes have been read.";
		} else {
			return "" + bytesRead + " of " + contentLength + " bytes have been read (" + percentDone + "% done).";
		}
	}

	public long getNum100Ks() {
		return num100Ks;
	}

	public void setNum100Ks(long num100Ks) {
		this.num100Ks = num100Ks;
	}

	public long getBytesRead() {
		return bytesRead;
	}

	public void setTheBytesRead(long theBytesRead) {
		this.bytesRead = theBytesRead;
	}

	public long getContentLength() {
		return contentLength;
	}

	public void setTheContentLength(long theContentLength) {
		this.contentLength = theContentLength;
	}

	public int getWhichItem() {
		return whichItem;
	}

	public void setWhichItem(int whichItem) {
		this.whichItem = whichItem;
	}

	public int getPercentDone() {
		return percentDone;
	}

	public void setPercentDone(int percentDone) {
		this.percentDone = percentDone;
	}

	public boolean isContentLengthKnown() {
		return contentLengthKnown;
	}

	public void setContentLengthKnown(boolean contentLengthKnown) {
		this.contentLengthKnown = contentLengthKnown;
	}


}
