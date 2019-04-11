------------------------
-- #region もぐらキャラクタークラス
------------------------
MogChar = {}
------------------------
-- #region コンストラクタ
-- name			:キャラ固有名（キャラ固有の特殊条件の判定に使用）
-- img_off		:マウスoff時画像
-- img_over		:マウスover時画像
-- img_on		:マウスon時画像
-- point		:もぐら叩き時ポイント
-- x			:表示調整用相対値x
-- y			:表示調整用相対値y
-- z			:表示調整用相対値z
------------------------
MogChar.new = function(name, img_off, img_over, img_on, point, x, y, z)
	-- メンバ変数
	local obj = {}
	-- 画像設定
	obj.name = name
	obj.img_off = img_off
	obj.img_over = img_over or obj.img_off
	obj.img_on = img_on or obj.img_off
	-- ポイント
	obj.point = point or 10

	-- 表示相対x,y,z設定（省略されている場合は0を設定）
	obj.x = x or 0
	obj.y = y or 0
	obj.z = z or 0

	-- 出現回数
	obj.show_count = 0
	--叩かれた回数
	obj.hit_count = 0

	return obj
end
-- #endregion
-- #endregion
------------------------
