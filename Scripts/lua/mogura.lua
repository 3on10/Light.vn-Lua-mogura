------------------------
-- #region 初期化・終了・更新・合計時間・合計点数設定
------------------------
-- #region 初期化
------------------------
function mogura_init()
	-- キートリガー無効
	lvCmd("キートリガー r.click none")
	lvCmd("キートリガー wheel.up none")
	lvCmd("キートリガー wheel.down none")
	lvCmd("キートリガー wheel.click none")
	lvCmd("キートリガー enter none")
	lvCmd("キートリガー esc none")
	lvCmd("キートリガー space none")
	lvCmd("キートリガー ctrl.l none")
	lvCmd("キートリガー ctrl.r none")
	lvCmd("キートリガー shift.l none")
	lvCmd("キートリガー shift.r none")

	-- 背景画像等定義
	if g_mog_mode == 1 or g_mog_mode == 2 or g_mog_mode == 3 then
		lvCmd("背景 bg0 bg\\sd3_bg.png")
		lvCmd("絵 bg1 bg\\sd3_bg_m01.png 0 0 60")
		lvCmd("絵 bg2 bg\\sd3_bg_m02.png 0 0 50")
	elseif g_mog_mode == 4 then
		lvCmd("背景 bg0 bg\\sd3_bg.png")
	elseif g_mog_mode == 5 then
		lvCmd("背景 bg0 bg\\BG04a_80.png")
	end

	-- もぐらキャラクター生成
	mog_char_tbl = {}
	if g_mog_mode == 1 or g_mog_mode == 2 or g_mog_mode == 3 then
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("mog0", "scg/cha_def_01_a", "scg/cha_def_01_a", "scg/cha_def_01_c", 10)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog1", "scg/cha_la01_01_a", "scg/cha_la01_01_a", "scg/cha_la01_01_c", 10, 2)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog2", "scg/cha_la02_01_a", "scg/cha_la02_01_a", "scg/cha_la02_01_c", 20, 5)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog3", "scg/cha_la03_01_a", "scg/cha_la03_01_a", "scg/cha_la03_01_c", 30, -5)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog4", "scg/cha_st01_01_a", "scg/cha_st01_01_a", "scg/cha_st01_01_c", 10, 8)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog5", "scg/cha_st02_01_a", "scg/cha_st02_01_a", "scg/cha_st02_01_c", 20, 8)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog6", "scg/cha_st03_01_a", "scg/cha_st03_01_a", "scg/cha_st03_01_c", 30, 8)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog7", "scg/cha_wo01_01_a", "scg/cha_wo01_01_a", "scg/cha_wo01_01_c", 10, -30)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog8", "scg/cha_wo02_01_a", "scg/cha_wo02_01_a", "scg/cha_wo02_01_c", 20, -30)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog9", "scg/cha_wo03_01_a", "scg/cha_wo03_01_a", "scg/cha_wo03_01_c", 30, -30)
	elseif g_mog_mode == 4 or g_mog_mode == 5 then
		-- kaniをたくさん作って擬似的に出現確率を操作する。この場合は約1/10の確率でmog0が出現する
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] = MogChar.new("kani", "scg/kani", "scg/kani", "scg/kani", 10, 0, 50)
		mog_char_tbl[#mog_char_tbl + 1] =
			MogChar.new("mog0", "scg/cha_def_01_a", "scg/cha_def_01_a", "scg/cha_def_01_c", -100)
	end

	-- もぐら表示位置生成
	mog_axes_tbl = {}
	if g_mog_mode == 1 or g_mog_mode == 3 or g_mog_mode == 4 then
		for i = 1, g_mog_x_num * g_mog_y_num, 1 do
			mog_axes_tbl[i] = MogAxes.new(i)
		end
	elseif g_mog_mode == 2 then
		-- キー値,表示基準x座標(左上),表示基準y座標(左上),表示基準z位置,出現時移動量y,出現時移動量x,退場時移動量y,退場時移動量x
		mog_axes_tbl[#mog_axes_tbl + 1] = MogAxes.new(#mog_axes_tbl + 1, 250, 55, 41, nil, nil, 250)
		mog_axes_tbl[#mog_axes_tbl + 1] = MogAxes.new(#mog_axes_tbl + 1, 105, 205, 51, nil, nil, 500)
		mog_axes_tbl[#mog_axes_tbl + 1] = MogAxes.new(#mog_axes_tbl + 1, 500, 15, 42, 0, -700, 0, 0)
	elseif g_mog_mode == 5 then
		for i = 1, g_mog_x_num * g_mog_y_num, 1 do
			mog_axes_tbl[i] = MogAxes.new(i, 0, 11 * i, 70 + i, 0, 1500, 0, 0)
		end
	end

	-- もぐらデバッグ文字生成
	mog_debug_tbl = {}
	for key, value in pairs(mog_axes_tbl) do
		mog_debug_tbl[key] = MogDebug.new(key)
	end

	-- もぐら表示数調整
	local disp_num = g_mog_disp_num
	-- 表示数が出現座標数より多ければ出現座標分を設定する
	if disp_num > #mog_axes_tbl then
		disp_num = #mog_axes_tbl
	end

	-- もぐらインスタンス生成
	mog_tbl = {}
	for i = 1, disp_num, 1 do
		mog_tbl[i] = Mog.new(i)
	end

	-- もぐら初期化
	math.randomseed(os.time()) -- 乱数調整
	math.random(1, 2) -- dumy. 1回目はランダム値が得られない（らしい）ため
	for key, value in pairs(mog_tbl) do
		-- もぐらコルーチンを呼び出す
		coroutine.resume(mog_tbl[key].co, true)
	end

	-- 合計点数表示設定
	mog_set_total_point()
	mog_update_total_point()

	-- 残り時間設定
	mog_set_remain_time()
	mog_update_remain_time()

	-- もぐら更新タイマーセット
	local timer = string.format("~砂時計 mog_timer_update %d 反復 スクリプト %s mog_update", g_mog_update_time, g_mog_txt_name)
	lvCmd(timer)
end
-- #endregion
------------------------
------------------------
-- #region 終了
------------------------
function mogura_end()
	-- キートリガー無効
	lvCmd("キートリガー l.click none") -- 左クリックを一時的に無効に
	for key, value in pairs(mog_tbl) do
		-- 終了処理
		mog_tbl[key]:finish()
	end
	-- インスタンス消去
	mog_tbl = nil
	-- もぐら更新タイマー解除
	lvCmd(string.format("~砂時計解除 mog_timer_update"))
	-- もぐら全タイマー解除（念の為）
	lvCmd(string.format("~砂時計解除 mog_timer.*"))
	-- 合計点数表示更新
	mog_update_total_point()
	-- キートリガー設定
	lvCmd("キートリガー初期化")
	lvCmd("キートリガー wheel.down 続行")
	lvCmd("キートリガー l.click 続行")
	lvCmd("キートリガー enter 続行")
end
-- #endregion
------------------------
------------------------
-- #region 残り時間表示・更新
------------------------
function mog_set_remain_time()
	-- 固定文字設定
	lvCmd(string.format('~文字 mog_remain_time_pre 10 0 81 %s 24 "残り時間："', g_mog_font))
end
function mog_update_remain_time()
	if g_mog_remain_time < 0 then
		g_mog_remain_time = 0
	end
	local sec = math.floor(g_mog_remain_time / 1000)
	local mic = math.floor(g_mog_remain_time % 1000 / 100)
	local sec_x = sec >= 10 and 140 or 152
	lvCmd(string.format('~文字 mog_remain_time_sec %d 0 81 %s 24 "{{%d}}"', sec_x, g_mog_font, sec))
	lvCmd(string.format('~文字 mog_remain_time_dot 170 0 81 %s 24 "."', g_mog_font))
	lvCmd(string.format('~文字 mog_remain_time_min 180 0 81 %s 24 "{{%d}}"', g_mog_font, mic))
	if g_mog_remain_time == 0 then
		lvCmd("ジャンプ mog_finish")
		g_mog_finish_flg = true -- 終了フラグON
	end
end
-- #endregion
------------------------
------------------------
-- #region 合計点数表示・更新
------------------------
function mog_set_total_point()
	lvCmd("~変数 total_point = 0")
	-- 固定文字設定
	lvCmd(string.format('~文字 mog_total_point_pre 10 30 81 %s 24 "合計点数："', g_mog_font))
end
function mog_update_total_point()
	local x = 170 -- 表示開始y位置
	local x_offset = 10 -- 桁数ごとに文字をずらすオフセット値
	if g_mog_total_point < -1000 then
		x = x - x_offset * 4
	elseif g_mog_total_point >= -1000 and g_mog_total_point < -100 then
		x = x - x_offset * 3
	elseif g_mog_total_point >= -100 and g_mog_total_point < -10 then
		x = x - x_offset * 2
	elseif g_mog_total_point >= -10 and g_mog_total_point < 0 then
		x = x - x_offset * 1
	elseif g_mog_total_point >= 0 and g_mog_total_point < 10 then
		x = x - x_offset * 0
	elseif g_mog_total_point >= 10 and g_mog_total_point < 100 then
		x = x - x_offset * 1
	elseif g_mog_total_point >= 100 and g_mog_total_point < 1000 then
		x = x - x_offset * 2
	elseif g_mog_total_point >= 1000 then
		x = x - x_offset * 3
	end
	lvCmd(string.format("変数 total_point = %d", g_mog_total_point))
	lvCmd(string.format('~文字 mog_total_point %d 30 81 %s 24 "{{ total_point }}"', x, g_mog_font))
end
-- #endregion
------------------------
-- #endregion
------------------------
