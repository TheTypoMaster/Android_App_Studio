package com.shenma.yueba.baijia.modle;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**  
 * @author gyj  
 * @version 创建时间：2015-6-4 下午4:12:34  
 * 程序的简单说明  发现品牌信息
 */

public class BrandInfoBean implements Serializable{
	List<BrandInfo> items=new ArrayList<BrandInfo>();
	public List<BrandInfo> getItems() {
		return items;
	}

	public void setItems(List<BrandInfo> items) {
		this.items = items;
	}

	int pageindex;
    int pagesize;
    int totalcount;
    int totalpaged;
    boolean ispaged=false;
	public int getPageindex() {
		return pageindex;
	}

	public void setPageindex(int pageindex) {
		this.pageindex = pageindex;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public int getTotalpaged() {
		return totalpaged;
	}

	public void setTotalpaged(int totalpaged) {
		this.totalpaged = totalpaged;
	}

	public boolean isIspaged() {
		return ispaged;
	}

	public void setIspaged(boolean ispaged) {
		this.ispaged = ispaged;
	}
}
