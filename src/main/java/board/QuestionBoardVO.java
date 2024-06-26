package board;

public class QuestionBoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String hostIp;
	private int readNum;
	private String wDate;
	private String part;
	private int good;
	private int report;
	
	private int hour_diff; // 게시글 업로드 24시간 경과유무 체크변수
	private int date_diff; // 게시글 일자 경과유무 체크변수	
	private int replyCnt; // 부모글의 댓글 수 저장하는 변수
	
	private int reCnt;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	public int getHour_diff() {
		return hour_diff;
	}
	public void setHour_diff(int hour_diff) {
		this.hour_diff = hour_diff;
	}
	public int getDate_diff() {
		return date_diff;
	}
	public void setDate_diff(int date_diff) {
		this.date_diff = date_diff;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	
	public int getReCnt() {
		return reCnt;
	}
	public void setReCnt(int reCnt) {
		this.reCnt = reCnt;
	}
	@Override
	public String toString() {
		return "QuestionBoardVO [idx=" + idx + ", mid=" + mid + ", nickName=" + nickName + ", title=" + title + ", content="
				+ content + ", hostIp=" + hostIp + ", readNum=" + readNum + ", wDate=" + wDate + ", part=" + part + ", good="
				+ good + ", report=" + report + ", hour_diff=" + hour_diff + ", date_diff=" + date_diff + ", replyCnt="
				+ replyCnt + ", reCnt=" + reCnt + "]";
	}
	
}
