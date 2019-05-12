--require("Panel1")
Panel2 = {}
local btnTrans
local transform 
function Panel2.Start(trans)
    transform = trans
    btnTrans = trans:Find("Button") 
    --local btn = btnTrans:GetComponent(typeof(UnityEngine.UI.Button))
    UUIEventListener.Get(btnTrans).onClick = Panel2.OnClick
    --btn.onClick:AddListener(Panel1.OnClick)
end

function Panel2.OnClick()
    print("点击了按钮")
    --local canvas = UnityEngine.GameObject.Find("Canvas(Clone)")
    -- local res =  ResourcesMgr.New()
    -- local obj =  res:LoadAsset("UIPrefabs/Panel1",false	)
	-- obj.transform:SetParent(canvas.transform,false)
    -- Panel1.Start(obj.transform)
    -- if transform ~= nil then
    --     UnityEngine.GameObject. Destroy(transform.gameObject)
    -- end

    local canvas = UnityEngine.GameObject.Find("Canvas(Clone)")
	local tmp = SUIFW.ABMgr.Instance():LoadAsset("uiprefabs", "uiprefabs/uiprefabs.ab", "Panel1.prefab", false);
    if tmp then
        local obj =  UnityEngine.GameObject.Instantiate(tmp)
        obj.transform:SetParent(canvas.transform,false)
        Panel1.Start(obj.transform)
        if transform ~= nil then
            UnityEngine.GameObject. Destroy(transform.gameObject)
        end
    end
end


return Panel2