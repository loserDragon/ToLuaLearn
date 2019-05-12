--require("Panel2")
Panel1 = {}
local btnTrans
local transform 
local Text
--加载出panel1后，把他的transform传递过来
--通过transform，就可以操作他下面的任何物体了
function Panel1.Start(trans)
    --记录，用于后面的销毁
    transform = trans
    --查找到Button物体
    btnTrans = trans:Find("Button")
    --这是后面修改界面添加的，查找到text物体
    Text = trans:Find("Text"):GetComponent(typeof(UnityEngine.UI.Text))
    --注册按钮点击事件
    UUIEventListener.Get(btnTrans).onClick = Panel1.OnClick

    ----这是后面修改界面添加的，查找三个按钮
    local btn1 =  trans:Find("Button (1)")
    local btn2 =  trans:Find("Button (2)")
    local btn3 =  trans:Find("Button (3)")

    --注册按钮点击事件
    UUIEventListener.Get(btn1).onClick = Panel1.OnClick1
    UUIEventListener.Get(btn2).onClick = Panel1.OnClick2
    UUIEventListener.Get(btn3).onClick = Panel1.OnClick3
end
function Panel1.OnClick1()
    --修改界面上的显示内容
    Text.text = "按钮1"
end
function Panel1.OnClick2()
    --修改界面上的显示内容
    Text.text = "按钮2"
end
function Panel1.OnClick3()
    --修改界面上的显示内容
    Text.text = "按钮3"
end


function Panel1.OnClick()
    print("点击了按钮")
    --找到Canvas(Clone)，UI的父物体
    local canvas = UnityEngine.GameObject.Find("Canvas(Clone)")
    --加载包体里的panel2预制
	local tmp = SUIFW.ABMgr.Instance():LoadAsset("uiprefabs", "uiprefabs/uiprefabs.ab", "Panel2.prefab", false);
    if tmp then
        --实例化
        local obj =  UnityEngine.GameObject.Instantiate(tmp)
        --设置父物体
        obj.transform:SetParent(canvas.transform,false)
        --将obj.transform传到Panel2.lua脚本里去
        Panel2.Start(obj.transform)
        if transform ~= nil then
            --销毁当前panel1
            UnityEngine.GameObject. Destroy(transform.gameObject)
        end
    end
end


return Panel1
