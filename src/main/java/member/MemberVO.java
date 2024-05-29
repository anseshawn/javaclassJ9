package member;

public class MemberVO {
	private int idx;
	private String name;
	private String mid;
	private String pwd;
	private String nickName;
	private String birthday;
	private String email;
	private String emailNews;
	private String phone;
	private String address;
	private String mGroup;
	private String cName;
	private String cCategory;
	private String cAddress;
	private String cTel;
	private String purpose;
	private int level;
	private int point;
	private String userDel;
	private String startDate;
	private String lastDate;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailNews() {
		return emailNews;
	}
	public void setEmailNews(String emailNews) {
		this.emailNews = emailNews;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getmGroup() {
		return mGroup;
	}
	public void setmGroup(String mGroup) {
		this.mGroup = mGroup;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getcCategory() {
		return cCategory;
	}
	public void setcCategory(String cCategory) {
		this.cCategory = cCategory;
	}
	public String getcAddress() {
		return cAddress;
	}
	public void setcAddress(String cAddress) {
		this.cAddress = cAddress;
	}
	public String getcTel() {
		return cTel;
	}
	public void setcTel(String cTel) {
		this.cTel = cTel;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getUserDel() {
		return userDel;
	}
	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", name=" + name + ", mid=" + mid + ", pwd=" + pwd + ", nickName=" + nickName
				+ ", birthday=" + birthday + ", email=" + email + ", emailNews=" + emailNews + ", phone=" + phone + ", address="
				+ address + ", mGroup=" + mGroup + ", cName=" + cName + ", cCategory=" + cCategory + ", cAddress=" + cAddress
				+ ", cTel=" + cTel + ", purpose=" + purpose + ", level=" + level + ", point=" + point + ", userDel=" + userDel
				+ ", startDate=" + startDate + ", lastDate=" + lastDate + "]";
	}
	
	
}
