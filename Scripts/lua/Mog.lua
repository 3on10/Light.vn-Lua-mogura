------------------------
-- #region もぐらクラス
------------------------
Mog = {}
------------------------
-- #region コンストラクタ
-- idx 	:キー値
------------------------
Mog.new = function(idx)
	-- メンバ変数
	local obj = {}
	-- キー値
	obj.idx = idx
	-- 処理待ち時間
	obj.mog_timer = 0
	-- 叩きフラグ
	obj.hit_flg = false
	-- もぐら状態コルーチン
	obj.co =
		coroutine.create(
		function(first)
			while true do
				first = first or false
				obj.state = "出現"
				-- 初期化
				while obj.axes == nil do
					obj:init(first)
				end
				obj.state = "退場"
				-- 出現
				obj:show()
				if obj.hit_flg == false then
					-- 時間切れ
					obj:over()
				end
				-- 退場
				obj:out()
			end
		end
	)
	-- メタテーブルセット
	setmetatable(obj, {__index = Mog})
	return obj
end
-- #endregion
------------------------
------------------------
-- #region メソッド定義
------------------------
------------------------
-- #region 演出時間リセット
------------------------
function Mog:time_reset()
	---------- 出現 ----------
	-- 出現時移動待ち時間
	self.show_wait = math.random(g_mog_show_tbl[1], g_mog_show_tbl[2])
	-- 出現時移動時間
	self.show_time = math.random(g_mog_show_tbl[3], g_mog_show_tbl[4])
	-- 出現時表示時間
	self.in_time = math.random(g_mog_show_tbl[5], g_mog_show_tbl[6])

	---------- 退場 ----------
	-- 退場時移動待ち時間
	self.hide_wait = math.random(g_mog_hide_tbl[1], g_mog_hide_tbl[2])
	-- 退場時移動時間
	self.hide_time = math.random(g_mog_hide_tbl[3], g_mog_hide_tbl[4])
	-- 消去時間
	self.out_time = math.random(g_mog_hide_tbl[5], g_mog_hide_tbl[6])
end
-- #endregion
------------------------
------------------------
-- #region 演出時間更新
------------------------
function Mog:time_update(time)
	-- 残り時間計算
	self.mog_timer = self.mog_timer - time >= 0 and self.mog_timer - time or 0
	self:debug_delete()
	self:debug_print(self.state .. "まで:" .. self.mog_timer, 10)
	-- コルーチン処理判定
	if g_mog_finish_flg ~= true and self.mog_timer == 0 then
		coroutine.resume(self.co)
	end
end
-- #endregion
------------------------
------------------------
-- #region 初期化
------------------------
function Mog:init(first_flg)
	-- 他のもぐら初期化中は待つ
	while g_mog_init_flg == true do
	end
	-- 初期化中フラグON
	g_mog_init_flg = true
	-- 空いている場所の配列を作る
	local empty_axes = {}
	for a_key, a_value in pairs(mog_axes_tbl) do
		local flg = true
		for m_key, m_value in pairs(mog_tbl) do
			if mog_tbl[m_key].axes ~= nil and mog_tbl[m_key].axes.idx == mog_axes_tbl[a_key].idx then
				flg = false
				break
			end
		end
		if flg then
			empty_axes[#empty_axes + 1] = mog_axes_tbl[a_key]
		end
	end
	-- 空いている場所があれば
	if #empty_axes > 0 then
		-- 次の表示予定位置設定
		self.axes = empty_axes[math.random(1, #empty_axes)]
		-- 次のキャラクター設定
		self.char = mog_char_tbl[math.random(1, #mog_char_tbl)]
		-- 演出時間再投入
		self:time_reset()
		-- 初回のみ、一斉に表示されては難しすぎるため次の表示待ち時間に前の表示秒数/2を加算する
		if first_flg ~= nil and self.idx > 1 then
			self.show_wait = self.show_wait + math.floor(mog_tbl[self.idx - 1].mog_timer / 2)
		end
		-- 次処理のタイマー設定
		self.mog_timer = self.out_time + self.show_wait
		-- デバッグモードでのidxとポイント文字も表示
		self:debug_print("もぐ:" .. self.idx, 24)
		self:debug_print("キャラ:" .. self.char.name, 24)
		self:debug_print("点:" .. self.char.point, 24)
		self:debug_print(self.state .. "まで:" .. self.mog_timer, 10)
	end
	-- 初期化中フラグOFF
	g_mog_init_flg = false
	coroutine.yield(self.co)
end
-- #endregion
------------------------
------------------------
-- #region 出現
------------------------
function Mog:show()
	-- 表示回数加算
	self.char.show_count = self.char.show_count + 1
	-- 文字列定義
	local btn =
		string.format(
		"~ボタン mog_btn%d %s.png %s.png %s.png %d %d %d スクリプト %s mog_hit %d",
		self.idx,
		self.char.img_off,
		self.char.img_over,
		self.char.img_on,
		self.axes.x + self.char.x + self.axes.show_mov_x,
		self.axes.y + self.char.y + self.axes.show_mov_y,
		self.axes.z + self.char.z,
		g_mog_txt_name,
		self.idx
	)
	local btn_in = string.format("~イン mog_btn%d %d", self.idx, self.in_time)
	-- 相対値移動は画面外退出不可（エンジン仕様）
	-- local btn_show =
	-- 	string.format(
	-- 	"~移動2 mog_btn%d %d %d %d",
	-- 	self.idx,
	-- 	self.axes.show_mov_x * -1,
	-- 	self.axes.show_mov_y * -1,
	-- 	self.show_time
	-- )
	-- 絶対値で位置を戻す
	local btn_show =
		string.format(
		"~移動 mog_btn%d %d %d %d",
		self.idx,
		self.axes.x + self.char.x - self.axes.show_mov_x,
		self.axes.y + self.char.y - self.axes.show_mov_y,
		self.show_time
	)
	-- スクリプト実行
	lvCmd(btn)
	lvCmd(btn_in)
	lvCmd(btn_show)
	-- 次処理のタイマー設定
	self.mog_timer = self.show_time + self.hide_wait
	coroutine.yield(self.co)
end
-- #endregion
------------------------
------------------------
-- #region 時間切れ
------------------------
function Mog:over()
	-- 相対値で位置を戻す
	lvCmd(string.format(".移動2 mog_btn%d %d %d %d", self.idx, self.axes.hide_mov_x, self.axes.hide_mov_y, self.hide_time))
	-- 次処理のタイマー設定
	self.mog_timer = self.hide_time
	coroutine.yield(self.co)
end
-- #endregion
------------------------
------------------------
-- #region もぐら消去
------------------------
function Mog:out()
	-- もぐら消す
	lvCmd(string.format("アウト mog_btn%d %d", self.idx, self.out_time))
	-- デバッグ文字初期化
	self:debug_init()
	-- 叩きフラグOFF
	self.hit_flg = false
	-- 座標クリア
	self.axes = nil
	-- 次処理のタイマー設定
	self.mog_timer = self.out_time
	coroutine.yield(self.co)
end
-- #endregion
------------------------
------------------------
-- #region 叩き
------------------------
function Mog:hit()
	-- 叩きフラグon
	self.hit_flg = true
	-- 叩き回数加算
	self.char.hit_count = self.char.hit_count + 1
	-- 合計ポイントにもぐらポイントを加算
	g_mog_total_point = g_mog_total_point + self.char.point
	-- 合計点数表示更新
	mog_update_total_point()

	-- 色を明滅させながら画面外に飛ばす
	str =
		string.format(
		"ループ 2 色調 mog_btn%d %d %d %d %d",
		self.idx,
		-- math.random(-360, 360),
		math.random(0, 255),
		math.random(0, 255),
		math.random(0, 255),
		math.random(50, 100)
	)
	lvCmd(str)
	-- 絶対値で位置を設定する
	str =
		string.format(
		"~移動 mog_btn%d %d %d %d",
		self.idx,
		math.random(-1500, 1500),
		math.random(-1500, 1500),
		math.random(250, 750)
	)
	lvCmd(str)
	str = string.format("ループ 2 回転 mog_btn%d %d %d", self.idx, math.random(-360, 360), math.random(250, 750))
	lvCmd(str)

	coroutine.resume(self.co)
end
-- #endregion
------------------------
------------------------
-- #region 終了
------------------------
function Mog:finish()
	if self.axes ~= nil then
		-- 絶対値で位置を戻す
		if self.axes.hide_mov_x > 0 or self.axes.hide_mov_y > 0 then
			lvCmd(
				string.format(
					"~移動 mog_btn%d %d %d %d",
					self.idx,
					self.axes.x + self.char.x + self.axes.hide_mov_x,
					self.axes.y + self.char.y + self.axes.hide_mov_y,
					-- self.hide_time
					500 --固定値で戻す（全キャラが同時に退場するようにする）
				)
			)
		end
	end
	-- もぐら消す
	lvCmd(string.format("アウト mog_btn%d %d", self.idx, self.out_time))
	-- デバッグ文字消去
	self:debug_init()
end
-- #endregion
------------------------
------------------------
-- #region デバッグ文字出力
------------------------
function Mog:debug_print(str, font_size)
	if debug_mode ~= true or self.axes == nil then
		return
	end
	-- mog_debugキー値
	local d_key = self.axes.idx
	-- デバッグパラメータ設定用クラスのインスタンス作成
	local dParam =
		MogDebugParam.new(
		self.idx,
		str,
		font_size,
		self.axes.x,
		self.axes.y + mog_debug_tbl[d_key]:get_y_offset(self.idx),
		self.axes.z + 1
	)
	-- パラメータ配列最大値設定
	local arrMax = #mog_debug_tbl[d_key].param + 1
	-- 文字表示
	local debug_str_id = string.format("mog_debug_str%d_%d_%d", d_key, self.idx, arrMax)
	local debug_str =
		string.format(
		'~文字 %s %d %d %d %s %d "[ %s ]"',
		debug_str_id,
		dParam.x,
		dParam.y,
		dParam.z,
		g_mog_font,
		dParam.size,
		dParam.str
	)
	-- パラメータ設定
	mog_debug_tbl[d_key].param[arrMax] = dParam
	lvCmd(debug_str)
	lvCmd(string.format("イン %s 0", debug_str_id))
end
-- #endregion
------------------------
------------------------
-- #region デバッグ文字初期化
------------------------
function Mog:debug_init()
	if debug_mode ~= true or self.axes == nil then
		return
	end
	-- mog_debugキー値
	local d_key = self.axes.idx
	-- 対象のデバッグ配列消去
	local index = 1
	local size = #mog_debug_tbl[d_key].param
	while index <= size do
		if mog_debug_tbl[d_key].param[index].idx == self.idx then
			mog_debug_tbl[d_key].param[index] = mog_debug_tbl[d_key].param[size]
			mog_debug_tbl[d_key].param[size] = nil
			size = size - 1
		else
			index = index + 1
		end
	end
	-- 文字アウト
	lvCmd(string.format("アウト mog_debug_str%d_%d_.* 0", d_key, self.idx))
	-- -- 残りの文字移動
	-- lvCmd(string.format("~移動2 mog_debug_str%d_.* +0 %d 0", d_key, mog_debug_tbl[d_key]:get_y_offset(self.idx) * -1))
end
-- #endregion
------------------------
------------------------
-- #region デバッグ文字消去
-- デバッグ文字の最後尾の文字列を消去する
------------------------
function Mog:debug_delete()
	if debug_mode ~= true or self.axes == nil then
		return
	end
	-- mog_debugキー値
	local d_key = self.axes.idx
	local arrMax = #mog_debug_tbl[d_key].param
	local debug_str_id = string.format("mog_debug_str%d_%d_%d", d_key, self.idx, arrMax)
	-- 文字アウト
	lvCmd(string.format("アウト %s 0", debug_str_id))
	-- テーブルから要素削除
	mog_debug_tbl[d_key].param[arrMax] = nil
end
-- #endregion
------------------------
-- #endregion
------------------------
-- #endregion
------------------------
