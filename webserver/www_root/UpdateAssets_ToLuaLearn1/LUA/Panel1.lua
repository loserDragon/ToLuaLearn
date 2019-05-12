--require("Panel2")
Panel1 = {}
local btnTrans
local transform 
local Text
function Panel1.Start(trans)
    transform = trans
    btnTrans = trans:Find("Button")
    Text = trans:Find("Text"):GetComponent(typeof(UnityEngine.UI.Text))
    --local btn = btnTrans:GetComponent(typeof(UnityEngine.UI.Button))
    UUIEventListener.Get(btnTrans).onClick = Panel1.OnClick
    --btn.onClick:AddListener(Panel1.OnClick)

    local btn1 =  trans:Find("Button (1)")
    local btn2 =  trans:Find("Button (2)")
    local btn3 =  trans:Find("Button (3)")

    UUIEventListener.Get(btn1).onClick = Panel1.OnClick1
    UUIEventListener.Get(btn2).onClick = Panel1.OnClick2
    UUIEventListener.Get(btn3).onClick = Panel1.OnClick3
end
function Panel1.OnClick1()
    Text.text = "按钮1"
end
function Panel1.OnClick2()
    Text.text = "按钮2"
end
function Panel1.OnClick3()
    Text.text = "按钮3"
end


function Panel1.OnClick()
    print("点击了按钮")
    --local canvas = UnityEngine.GameObject.Find("Canvas(Clone)")
    -- local res =  ResourcesMgr.New()
    -- local obj =  res:LoadAsset("UIPrefabs/Panel2",false	)
    -- obj.transform:SetParent(canvas.transform,false)
    -- Panel2.Start(obj.transform)
    -- if transform ~= nil then 
    --     UnityEngine.GameObject. Destroy(transform.gameObject)
    -- end

    local canvas = UnityEngine.GameObject.Find("Canvas(Clone)")
	local tmp = SUIFW.ABMgr.Instance():LoadAsset("uiprefabs", "uiprefabs/uiprefabs.ab", "Panel2.prefab", false);
    if tmp then
        local obj =  UnityEngine.GameObject.Instantiate(tmp)
        obj.transform:SetParent(canvas.transform,false)
        Panel2.Start(obj.transform)
        if transform ~= nil then
            UnityEngine.GameObject. Destroy(transform.gameObject)
        end
    end
end


return Panel1
