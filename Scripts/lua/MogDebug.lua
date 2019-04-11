------------------------
-- #region もぐらデバッグクラス
------------------------
MogDebug = {}
------------------------
-- #region コンストラクタ
-- idx 		:※注意 MogAxesのキー値
------------------------
MogDebug.new = function(idx)
	-- メンバ変数
	local obj = {}
	-- もぐら表示位置クラスのキー値をキー値としてセットする
	obj.idx = idx
	-- デバッグ用パラメータ保持テーブル
	obj.param = {}

	-- メタテーブルセット
	setmetatable(obj, {__index = MogDebug})
	return obj
end
-- #endregion
------------------------
------------------------
-- #region もぐらデバッグパラメータクラス
------------------------
MogDebugParam = {}
------------------------
-- #region コンストラクタ
-- idx		:※注意 Mogのキー値
-- str		:表示文字
-- font_size:フォントサイズ
-- x		:表示基準x座標
-- y		:表示基準y座標
-- z		:表示基準z位置
-- y_offset	:表示yオフセット値
------------------------
MogDebugParam.new = function(idx, str, font_size, x, y, z, y_offset)
	-- メンバ変数
	local obj = {}
	-- もぐらクラスのキー値をキー値としてセットする
	obj.idx = idx
	-- 文字
	obj.str = str
	-- フォントサイズ
	obj.size = font_size
	-- 座標x,y,z
	obj.x = x
	obj.y = y
	obj.z = z
	-- y方向オフセット値
	obj.y_offset = y_offset or math.floor(obj.size * 0.5)

	return obj
end
-- #endregion
------------------------
------------------------
-- #region 文字表示y位置の取得
-- mogIdx	:	Mogのキー値
------------------------
function MogDebug:get_y_offset(mogIdx)
	local y_offset = 0
	for key, value in pairs(self.param) do
		y_offset = y_offset + self.param[key].size + self.param[key].y_offset
	end
	return y_offset
end
-- #endregion
-- #endregion
------------------------
