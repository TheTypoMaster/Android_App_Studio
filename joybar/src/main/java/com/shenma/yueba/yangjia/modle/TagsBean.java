package com.shenma.yueba.yangjia.modle;

import java.io.Serializable;

public class TagsBean implements Serializable{
	private String Name;
	private String PosX;
	private String PosY;
	private int SourceId;//如果是品牌标签，这里传品牌的编号id
	private String SourceType;//标签类型      50表示普通标签        51表示品牌标签     52表示买手标签 
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getPosX() {
		return PosX;
	}
	public void setPosX(String posX) {
		PosX = posX;
	}
	public String getPosY() {
		return PosY;
	}
	public void setPosY(String posY) {
		PosY = posY;
	}

	public String getSourceType() {
		return SourceType;
	}
	public void setSourceType(String sourceType) {
		SourceType = sourceType;
	}
	public int getSourceId() {
		return SourceId;
	}
	public void setSourceId(int sourceId) {
		SourceId = sourceId;
	}

	
	
	
}
