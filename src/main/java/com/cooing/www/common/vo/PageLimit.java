package com.cooing.www.common.vo;

public class PageLimit {
	private int countPage;		//페이지당 글목록 수
	private int groupPage;		//그룹당 페이지 수 
	private int nowPage;		//현재 페이지 (최근 글이 1부터 시작)
	private int beginPage;		//현재 시작페이지
	private int endPage;		//현재 마지막 페이지
	private int totalboardCount;//전체 글 수
	private int totalPageCount;	//전체 페이지 수
	private int nowGroup;		//현재 그룹 (최근 그룹이 0부터 시작)
	private int startGroup;		//현재 그룹의 첫 페이지
	private int endGroup;		//현재 그룹의 마지막 페이지
	private int startBoard;		//전체 레코드 중 현재 페이지 첫 글의 위치 (0부터 시작)
	
	public PageLimit(int countPage, int groupPage, int nowPage, int totalboardCount) {
						//페이지당 글 수,   그룹당 페이지 수,   현재 페이지,       전체 글 수
		this.countPage = countPage;
		this.groupPage = groupPage;
		this.totalboardCount = totalboardCount;
		
		//전체 페이지 수
		if( totalboardCount % countPage == 0)
			totalPageCount = (totalboardCount / countPage);
		else
			totalPageCount = (totalboardCount / countPage) + 1;
		//전달된 현재 페이지가 1보다 작으면 현재페이지를 1페이지로 지정
		if (nowPage < 1)	nowPage = 1;
		//전달된 현재 페이지가 마지막 페이지보다 크면 현재페이지를 마지막 페이지로 지정
		if (nowPage > totalPageCount)	nowPage = totalPageCount;
		
		this.nowPage = nowPage;
		//현재있는 페이지에서 더 가기
		beginPage = nowPage - 2;
		if(beginPage<1) beginPage = 1;
		if(beginPage > totalPageCount) beginPage = totalPageCount;
		endPage = beginPage + 4;
		if(endPage < 1) endPage = 1;
		if(endPage > totalPageCount) endPage = totalPageCount; 
		//현재 그룹
		nowGroup = (nowPage - 1) / groupPage;		
		//현재 그룹의 첫 페이지
		startGroup = nowGroup * groupPage + 1;
		//현재 그룹의 첫 페이지가 1보다 작으면 1로 처리
		startGroup = startGroup < 1 ? 1 : startGroup;
		//현재 그룹의 마지막 페이지
		endGroup = startGroup + groupPage - 1;
		//현재 그룹의 마지막 페이지가 전체 페이지 수보다 작으면 전체페이지 수를 마지막으로.
		endGroup = endGroup < totalPageCount ? endGroup : totalPageCount;
		//전체 레코드 중 현재 페이지 첫 글의 위치
		startBoard = (nowPage - 1) * countPage;			
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public int getCountPage() {
		return countPage;
	}

	public void setCountPage(int countPage) {
		this.countPage = countPage;
	}

	public int getGroupPage() {
		return groupPage;
	}

	public void setGroupPage(int groupPage) {
		this.groupPage = groupPage;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getTotalboardCount() {
		return totalboardCount;
	}

	public void setTotalboardCount(int totalboardCount) {
		this.totalboardCount = totalboardCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getNowGroup() {
		return nowGroup;
	}

	public void setNowGroup(int nowGroup) {
		this.nowGroup = nowGroup;
	}

	public int getStartGroup() {
		return startGroup;
	}

	public void setStartGroup(int startGroup) {
		this.startGroup = startGroup;
	}

	public int getEndGroup() {
		return endGroup;
	}

	public void setEndGroup(int endGroup) {
		this.endGroup = endGroup;
	}

	public int getStartBoard() {
		return startBoard;
	}

	public void setStartBoard(int startBoard) {
		this.startBoard = startBoard;
	}

	@Override
	public String toString() {
		return "PageLimit [countPage=" + countPage + ", groupPage=" + groupPage + ", nowPage=" + nowPage
				+ ", totalboardCount=" + totalboardCount + ", totalPageCount=" + totalPageCount + ", nowGroup="
				+ nowGroup + ", startGroup=" + startGroup + ", endGroup=" + endGroup + ", startBoard=" + startBoard + 
				", endPage=" + endPage + ", beginPage=" + beginPage + "]";
	}
}
