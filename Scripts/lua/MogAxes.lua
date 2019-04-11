----------------------
-- #region もぐら表示位置クラス
------------------------
MogAxes = {}
------------------------
-- #region コンストラクタ
-- idx 		:キー値
-- x		:表示基準x座標(左上)
-- y		:表示基準y座標(左上)
-- z		:表示基準z位置
-- show_mov_y	:出現時移動量y
-- show_mov_x	:出現時移動量x
-- hide_mov_y	:退場時移動量y
-- hide_mov_x	:退場時移動量x
------------------------
MogAxes.new = function(idx, x, y, z, show_mov_y, show_mov_x, hide_mov_y, hide_mov_x)
	-- メンバ変数
	local obj = {}
	-- キー値
	obj.idx = idx

	-- x,y,z設定（省略されている時初期値を設定）
	-- 初期値の場合もぐらの配置
	-- [1] [2] [3]
	-- [4] [5] [6]
	obj.x = x or g_mog_x_offset + (obj.idx - 1) % g_mog_x_num * g_mog_x_size
	obj.y = y or g_mog_y_offset + math.floor((obj.idx - 1) / g_mog_x_num) * g_mog_y_size
	obj.z = z or 70 + (obj.idx - 1)

	-- 出現時移動量y
	obj.show_mov_y = show_mov_y or 100
	-- 出現時移動量x
	obj.show_mov_x = show_mov_x or 0
	-- 退場時移動量y
	obj.hide_mov_y = hide_mov_y or obj.show_mov_y
	-- 退場時移動量x
	obj.hide_mov_x = hide_mov_x or obj.show_mov_x

	return obj
end
-- #endregion
------------------------
-- #endregion
------------------------
