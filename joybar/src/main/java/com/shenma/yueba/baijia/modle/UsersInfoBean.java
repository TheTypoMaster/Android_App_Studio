package com.shenma.yueba.baijia.modle;

import java.io.Serializable;

/**  
 * @author gyj  
 * @version 创建时间：2015-5-27 下午1:43:16  
 * 程序的简单说明  
 */

public class UsersInfoBean implements Serializable{
	int UserId;//用户id
	String Logo;//用户头像
	String LikeTime;//时间
	public String getLikeTime() {
		return LikeTime;
	}
	public void setLikeTime(String likeTime) {
		LikeTime = likeTime;
	}
	public int getUserId() {
		return UserId;
	}
	public void setUserId(int userId) {
		UserId = userId;
	}
	public String getLogo() {
		return Logo;
	}
	public void setLogo(String logo) {
		Logo = logo;
	}

}
