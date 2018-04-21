package com.cooing.www.jinsu.object;

public class CategoryPop {
	private int category_pop_num;
	private int category_pop_kind;
	private String category_pop_date;
	
	public CategoryPop(){}
	public CategoryPop(int category_pop_num , int category_pop_kind , String category_pop_date){
		this.category_pop_num = category_pop_num;
		this.category_pop_kind = category_pop_kind;
		this.category_pop_date = category_pop_date;
	}
	public int getCategory_pop_num() {
		return category_pop_num;
	}
	public void setCategory_pop_num(int category_pop_num) {
		this.category_pop_num = category_pop_num;
	}
	public int getCategory_pop_kind() {
		return category_pop_kind;
	}
	public void setCategory_pop_kind(int category_pop_kind) {
		this.category_pop_kind = category_pop_kind;
	}
	public String getCategory_pop_date() {
		return category_pop_date;
	}
	public void setCategory_pop_date(String category_pop_date) {
		this.category_pop_date = category_pop_date;
	}
	@Override
	public String toString() {
		return "CategoryPop [category_pop_num=" + category_pop_num + ", category_pop_kind=" + category_pop_kind
				+ ", category_pop_date=" + category_pop_date + "]";
	}
}
