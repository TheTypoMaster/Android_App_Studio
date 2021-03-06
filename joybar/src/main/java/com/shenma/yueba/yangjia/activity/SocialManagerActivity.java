package com.shenma.yueba.yangjia.activity;

import java.util.ArrayList;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

import com.shenma.yueba.BaseFragmentActivity;
import com.shenma.yueba.R;
import com.shenma.yueba.application.MyApplication;
import com.shenma.yueba.baijia.adapter.MyFragmentPagerAdapter;
import com.shenma.yueba.constants.Constants;
import com.shenma.yueba.util.FontManager;
import com.shenma.yueba.yangjia.adapter.MyAttentionAndFansForSocialAdapter;
import com.shenma.yueba.yangjia.fragment.MyAttentionAndFansForSocialFragment;
import com.shenma.yueba.yangjia.fragment.MyCircleForSocialFragment;
import com.shenma.yueba.yangjia.fragment.ProductManagerFragmentForOnLine;
import com.umeng.analytics.MobclickAgent;

/**
 * 社交管理
 * 
 * @author a
 */
public class SocialManagerActivity extends BaseFragmentActivity implements
		OnClickListener {
	private ArrayList<ImageView> cursorImageList = new ArrayList<ImageView>();
	private ArrayList<TextView> titleTextList = new ArrayList<TextView>();
	private ImageView iv_cursor_left, iv_cursor_right;
	// private ImageView iv_cursor_center;
	private ViewPager viewpager_main;
	private MyCircleForSocialFragment myCircleForSocialFragment;// 买手街
	// private MyAttentionAndFansForSocialFragment myAttentionFragment;//我的关注
	private MyAttentionAndFansForSocialFragment myFansFragment;// 我的粉丝
	private ArrayList<Fragment> fragmentList = new ArrayList<Fragment>();
	private MyFragmentPagerAdapter myFragmentPagerAdapter;
	private TextView tv_top_left;
	private TextView tv_top_title;
	private int page = 1;
	private int index;
	private TextView tv_my_circle;
	// private TextView tv_my_attetion;
	private TextView tv_my_fans;
	private TextView tv_top_right;

	@Override
	protected void onCreate(Bundle arg0) {
		MyApplication.getInstance().addActivity(this);// 加入回退栈
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.social_manager_layout);
		initView();
		initFragment();
		initViewPager();
		myCircleForSocialFragment.getCircleListFromNet(
				SocialManagerActivity.this, true, true);
		super.onCreate(arg0);
	}

	private void initView() {
		tv_top_left = (TextView) findViewById(R.id.tv_top_left);
		tv_top_title = (TextView) findViewById(R.id.tv_top_title);
		tv_top_right = (TextView) findViewById(R.id.tv_top_right);
		tv_top_right.setVisibility(View.VISIBLE);
		tv_top_right.setBackgroundResource(R.drawable.add);
		tv_top_right.setOnClickListener(this);
		tv_top_left.setVisibility(View.VISIBLE);
		tv_top_title.setVisibility(View.VISIBLE);
		tv_top_title.setText("社交管理");
		tv_top_left.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				SocialManagerActivity.this.finish();
			}
		});

		tv_my_circle = (TextView) findViewById(R.id.tv_my_circle);
		tv_top_right.setOnClickListener(this);
		// tv_my_attetion = (TextView) findViewById(R.id.tv_my_attetion);
		tv_my_fans = (TextView) findViewById(R.id.tv_my_fans);
		tv_my_fans.setOnClickListener(this);
		tv_my_circle.setTextSize(20);
		tv_my_circle.setTextColor(getResources().getColor(R.color.main_color));
		tv_my_circle.setOnClickListener(this);
		// tv_my_attetion.setOnClickListener(this);
		tv_my_fans.setOnClickListener(this);

		titleTextList.add(tv_my_circle);
		// titleTextList.add(tv_my_attetion);
		titleTextList.add(tv_my_fans);
		iv_cursor_left = (ImageView) findViewById(R.id.iv_cursor_left);
		// iv_cursor_center = (ImageView) findViewById(R.id.iv_cursor_center);
		iv_cursor_right = (ImageView) findViewById(R.id.iv_cursor_right);
		iv_cursor_left.setVisibility(View.VISIBLE);
		cursorImageList.add(iv_cursor_left);
		// cursorImageList.add(iv_cursor_center);
		cursorImageList.add(iv_cursor_right);
		viewpager_main = (ViewPager) findViewById(R.id.viewpager_main);
		FontManager.changeFonts(this, tv_my_circle, tv_my_fans, tv_top_left,
				tv_top_title);
	}

	private void initFragment() {
		myCircleForSocialFragment = new MyCircleForSocialFragment();
		// myAttentionFragment = new MyAttentionAndFansForSocialFragment();
		myFansFragment = new MyAttentionAndFansForSocialFragment();
		fragmentList.add(myCircleForSocialFragment);
		// fragmentList.add(myAttentionFragment);
		fragmentList.add(myFansFragment);
		myFragmentPagerAdapter = new MyFragmentPagerAdapter(
				getSupportFragmentManager(), fragmentList);

	}

	private void initViewPager() {
		viewpager_main.setAdapter(myFragmentPagerAdapter);
		viewpager_main.setCurrentItem(0);
		viewpager_main.setOnPageChangeListener(new OnPageChangeListener() {

			public void onPageScrolled(int arg0, float arg1, int arg2) {
			}

			/*
			 * 页面跳转完成后调用的方法
			 */
			public void onPageSelected(int arg0) {
				setCursorAndText(arg0, cursorImageList, titleTextList);
				index = arg0;
				switch (index) {
				case 0:
					myFansFragment.tv_nodata.setVisibility(View.GONE);
					tv_top_right.setVisibility(View.VISIBLE);
					myCircleForSocialFragment.getData(
							SocialManagerActivity.this, true, true);
					break;
				case 1:
					myCircleForSocialFragment.tv_nodata
							.setVisibility(View.GONE);
					tv_top_right.setVisibility(View.GONE);
					myFansFragment.getData(1, SocialManagerActivity.this, true);// 0表示我关注的人
																				// 1表示我的粉丝
					break;
				//
				// case 2 :
				// myAttentionFragment.getData("0",
				// SocialManagerActivity.this,true);// 0表示我关注的人 1表示我的粉丝
				// break;
				default:
					break;
				}

			}

			@Override
			public void onPageScrollStateChanged(int arg0) {
				// TODO Auto-generated method stub

			}
		});

	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.tv_my_circle:// 我的圈子
			viewpager_main.setCurrentItem(0);
			break;
		case R.id.tv_my_fans:// 我的粉丝
			viewpager_main.setCurrentItem(1);
			break;
		case R.id.tv_top_right:// 添加圈子
			Intent intent = new Intent(SocialManagerActivity.this,
					AddCircleActivity.class);
			startActivityForResult(intent, Constants.REQUESTCODE);
			break;
		default:
			break;
		}

	}

	@Override
	protected void onActivityResult(int request, int result, Intent arg2) {
		if (request == Constants.REQUESTCODE && result == Constants.RESULTCODE) {
			myCircleForSocialFragment.getCircleListFromNet(
					SocialManagerActivity.this, true, true);
		}
		super.onActivityResult(request, result, arg2);
	}

	@Override
	protected void onDestroy() {
		MyApplication.getInstance().removeActivity(this);// 移除activity列表
		super.onDestroy();
	}

	public void onResume() {
		super.onResume();
		MobclickAgent.onResume(this);
	}

	public void onPause() {
		super.onPause();
		MobclickAgent.onPause(this);
	}
}
