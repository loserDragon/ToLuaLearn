--require("Panel2")
Panel1 = {}
local btnTrans
local transform 
function Panel1.Start(trans)
    transform = trans
    btnTrans = trans:Find("Button") 
    --local btn = btnTrans:GetComponent(typeof(UnityEngine.UI.Button))
    UUIEventListener.Get(btnTrans).onClick = Panel1.OnClick
    --btn.onClick:AddListener(Panel1.OnClick)
end

function Panel1.OnClick()
    print("点击了按钮")
    local canvas = UnityEngine.GameObject.Find("Canvas(Clone)")
    local res =  ResourcesMgr.New()
    local obj =  res:LoadAsset("UIPrefabs/Panel2",false	)
    obj.transform:SetParent(canvas.transform,false)
    Panel2.Start(obj.transform)
    if transform ~= nil then 
        UnityEngine.GameObject. Destroy(transform.gameObject)
    end
end

return Panel1  
