package com.cooing.www.jinsu.object;

public class Search {
	
	private int search_num;
	private String search_word;
	private String search_date;
	
	public Search(){}
	public Search(int search_num , String search_word , String search_date){
		this.search_num = search_num;
		this.search_word = search_word;
		this.search_date = search_date;
	}
	public int getSearch_num() {
		return search_num;
	}
	public void setSearch_num(int search_num) {
		this.search_num = search_num;
	}
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public String getSearch_date() {
		return search_date;
	}
	public void setSearch_date(String search_date) {
		this.search_date = search_date;
	}
	@Override
	public String toString() {
		return "Search [search_num=" + search_num + ", search_word=" + search_word + ", search_date=" + search_date
				+ "]";
	}
}
