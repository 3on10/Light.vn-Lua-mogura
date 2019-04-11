------------------------
-- #region もぐら更新
-- lua内で栞を設定すると強制終了のため栞はシナリオファイルに直接記述する
------------------------
function mogura_update()
	-- 残り時間計算(- math.floor(g_mog_update_time / 10)は調整用)
	local time = g_mog_update_time + math.floor(g_mog_update_time / 10)
	g_mog_remain_time = g_mog_remain_time - time
	mog_update_remain_time()
	-- もぐら状態更新確認
	for key, value in pairs(mog_tbl) do
		mog_tbl[key]:time_update(time)
	end
end
-- #endregion
------------------------
------------------------
-- #region ボタン押下判定
------------------------
function mogura_hit(idx)
	mog_tbl[idx]:hit()
end
-- #endregion
------------------------
