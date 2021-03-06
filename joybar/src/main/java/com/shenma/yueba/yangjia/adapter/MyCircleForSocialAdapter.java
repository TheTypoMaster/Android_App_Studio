package com.shenma.yueba.yangjia.adapter;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.shenma.yueba.R;
import com.shenma.yueba.application.MyApplication;
import com.shenma.yueba.baijia.adapter.BaseAdapterWithUtil;
import com.shenma.yueba.util.FontManager;
import com.shenma.yueba.util.ToolsUtil;
import com.shenma.yueba.view.RoundImageView;
import com.shenma.yueba.yangjia.modle.CirlceItemBean;

public class MyCircleForSocialAdapter extends BaseAdapterWithUtil {
	private List<CirlceItemBean> mList;

	public MyCircleForSocialAdapter(Context ctx, List<CirlceItemBean> mList) {
		super(ctx);
		this.mList = mList;
	}

	@Override
	public int getCount() {
		
		return mList.size();
	}

	@Override
	public Object getItem(int position) {
		
		return mList.get(position);
	}

	@Override
	public long getItemId(int position) {
		
		return position;
	}

	@SuppressWarnings("null")
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		Holder holder;
		if (convertView == null) {
			holder = new Holder();
			convertView = View.inflate(ctx, R.layout.my_circle_for_social_item,
					null);
			holder.ri_circle_head = (RoundImageView) convertView
					.findViewById(R.id.ri_circle_head);
			holder.tv_circle_name = (TextView) convertView
					.findViewById(R.id.tv_circle_name);
			holder.tv_attention_count = (TextView) convertView
					.findViewById(R.id.tv_attention_count);
			convertView.setTag(holder);
		} else {
			holder = (Holder) convertView.getTag();
		}
		initBitmap(mList.get(position).getLogo(), holder.ri_circle_head);
		holder.tv_circle_name.setText(ToolsUtil.nullToString(mList.get(position).getName()));
		holder.tv_attention_count.setText("成员："+ToolsUtil.nullToString(mList.get(position).getUserCount()));
		FontManager.changeFonts(ctx, holder.tv_circle_name,
				holder.tv_attention_count);
		return convertView;
	}

	class Holder {
		RoundImageView ri_circle_head;
		TextView tv_circle_name;
		TextView tv_attention_count;
	}
	
	void initBitmap(final String url, final ImageView iv) {
		MyApplication.getInstance().getBitmapUtil().display(iv, url);
	}

}
