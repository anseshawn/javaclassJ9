package board;

public class ReportVO {
	private int idx;
	private String board;
	private int boardIdx;
	private String rpMid;
	private String rpContent;
	private String rpDate;
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
	public String getRpMid() {
		return rpMid;
	}
	public void setRpMid(String rpMid) {
		this.rpMid = rpMid;
	}
	public String getRpContent() {
		return rpContent;
	}
	public void setRpContent(String rpContent) {
		this.rpContent = rpContent;
	}
	public String getRpDate() {
		return rpDate;
	}
	public void setRpDate(String rpDate) {
		this.rpDate = rpDate;
	}
	@Override
	public String toString() {
		return "ReportVO [idx=" + idx + ", board=" + board + ", boardIdx=" + boardIdx + ", rpMid=" + rpMid + ", rpContent="
				+ rpContent + ", rpDate=" + rpDate + "]";
	}
	
}
