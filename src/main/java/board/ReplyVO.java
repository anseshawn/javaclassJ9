package board;

public class ReplyVO {
	private int idx;
	private String board;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String rDate;
	private String hostIp;
	private String content;
	private int report;
	
	private int hour_diff; // 업로드 24시간 경과유무 체크변수
	private int date_diff; // 일자 경과유무 체크변수
	
	// reReply 테이블
	private int reIdx;
	private int replyIdx;
	private String reMid;
	private String reNickName;
	private String reDate;
	private String reHostIp;
	private String reContent;
	private int reReport;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getBoard() {
		return board;
	}
	public void setBoard(String board) {
		this.board = board;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
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
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	//reReply
	public int getReIdx() {
		return reIdx;
	}
	public void setReIdx(int reIdx) {
		this.reIdx = reIdx;
	}
	public int getReplyIdx() {
		return replyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		this.replyIdx = replyIdx;
	}
	public String getReMid() {
		return reMid;
	}
	public void setReMid(String reMid) {
		this.reMid = reMid;
	}
	public String getReNickName() {
		return reNickName;
	}
	public void setReNickName(String reNickName) {
		this.reNickName = reNickName;
	}
	public String getReDate() {
		return reDate;
	}
	public void setReDate(String reDate) {
		this.reDate = reDate;
	}
	public String getReHostIp() {
		return reHostIp;
	}
	public void setReHostIp(String reHostIp) {
		this.reHostIp = reHostIp;
	}
	public String getReContent() {
		return reContent;
	}
	public void setReContent(String reContent) {
		this.reContent = reContent;
	}
	public int getReReport() {
		return reReport;
	}
	public void setReReport(int reReport) {
		this.reReport = reReport;
	}
	@Override
	public String toString() {
		return "ReplyVO [idx=" + idx + ", board=" + board + ", boardIdx=" + boardIdx + ", mid=" + mid + ", nickName="
				+ nickName + ", rDate=" + rDate + ", hostIp=" + hostIp + ", content=" + content + ", report=" + report
				+ ", hour_diff=" + hour_diff + ", date_diff=" + date_diff + ", reIdx=" + reIdx + ", replyIdx=" + replyIdx
				+ ", reMid=" + reMid + ", reNickName=" + reNickName + ", reDate=" + reDate + ", reHostIp=" + reHostIp
				+ ", reContent=" + reContent + ", reReport=" + reReport + "]";
	}
	
}
