-- Luaグローバル変数のプレフィックス：g_mog
-- 内部処理用（関数・タイマー・ボタン等）のプレフィックス：mog_
-- light.vn側からの呼び出し用関数プレフィックス：mogura_
------------------------
-- #region 変数・設定値定義
------------------------
-- #region mogura_setting
-- mode		:ゲームモード
-- debug_on	:デバッグON/OFF(T/F)
------------------------
function mogura_setting(mode, debug_on)
	-- light.vn側でのテキストファイル名
	g_mog_txt_name = "mog_main.txt"
	-- 使用するフォント
	g_mog_font = "NotoSansCJKjp-Regular.ttf"

	-- デバッグ時tureに設定
	if debug_on == nil then
		debug_mode = false
	else
		debug_mode = debug_on
	end
	-- モード設定用
	g_mog_mode = mode

	-- ゲーム終了フラグ
	g_mog_finish_flg = false
	-- もぐら初期化中フラグ
	g_mog_init_flg = false
	-- 合計点数
	g_mog_total_point = 0

	-- （必要に応じてモード別に設定）
	-- 合計時間（15.0秒）
	g_mog_remain_time = 15000
	-- もぐら更新タイミング（ミリ秒）※100ミリ秒周期更新ぐらいがちょうどよいと思います
	g_mog_update_time = 100

	-- もぐら表示開始位置x
	g_mog_x_offset = 150
	-- もぐら表示開始位置y
	g_mog_y_offset = 100
	-- もぐら1体分の表示間隔xサイズ
	g_mog_x_size = 300
	-- もぐら1体分の表示間隔yサイズ
	g_mog_y_size = 200

	-- x方向表示数
	g_mog_x_num = 3
	-- y方向表示数
	g_mog_y_num = 2
	-- 最大もぐら表示数
	g_mog_disp_num = 4

	-- もぐら表示用乱数生成設定値（ミリ秒）
	-- 待ち秒始点,待ち秒終点,移動秒始点,移動秒終点,フェードイン秒始点,フェードイン秒終点
	g_mog_show_tbl = {250, 1000, 500, 1000, 250, 250}

	-- もぐら退場用乱数生成設定値（ミリ秒）
	-- 待ち秒始点,待ち秒終点,移動秒始点,移動秒終点,フェードアウト秒始点,フェードアウト秒終点
	g_mog_hide_tbl = {500, 1000, 250, 250, 250, 250}

	-- モード別に表示速度等変更
	if g_mog_mode == 3 then
		-- サンプル1（難）モード
		g_mog_disp_num = 6
		g_mog_show_tbl = {250, 500, 250, 500, 250, 250}
		g_mog_hide_tbl = {250, 500, 100, 250, 150, 150}
	elseif g_mog_mode == 5 then
		-- カニモード
		g_mog_x_num = 5
		g_mog_y_num = 10
		g_mog_disp_num = 50
		g_mog_show_tbl = {0, 50, 500, 2500, 0, 0}
		g_mog_hide_tbl = {0, 0, 250, 250, 250, 250}
	end

end
-- #endregion
------------------------
-- #endregion
------------------------
