local ctrl = require("Ctrl")
local canvas
local Panel1 = require("Panel1")
local Panel2 = require("Panel2")
--主入口函数。从这里开始lua逻辑
function Main()					
	print("logic start")
	--调用ctrl的初始方法	
	--ctrl.start() 
	--Init()
	Init1()
end
--默认加载panel1界面
function Init1()
	--构造一个ResourcesMgr对象
	local res =  ResourcesMgr.New()
	--通过resources加载Canvas
	canvas =  res:LoadAsset("Canvas",false	)
	--将InitPanel(显示正在加载中的界面)隐藏
	UnityEngine.GameObject.Find("InitPanel"):SetActive(false)
	--加载预制包体
	SUIFW.ABMgr.Instance():LoadAssetBundlePack("uiprefabs", "uiprefabs/uiprefabs.ab",Callback)
end

function Callback(abName)
	--加载Panel1预制
	local tmp = SUIFW.ABMgr.Instance():LoadAsset("uiprefabs", "uiprefabs/uiprefabs.ab", "Panel1.prefab", false);
		if tmp then
			--实例化
			local obj =  UnityEngine.GameObject.Instantiate(tmp)
			--设置父物体
			obj.transform:SetParent(canvas.transform,false)
			--将transform传进去
			Panel1.Start(obj.transform)
		end
end

--这里是之前在Resurces里加载
function Init()


	local res =  ResourcesMgr.New()
	canvas =  res:LoadAsset("Canvas",false	)

	local obj =  res:LoadAsset("UIPrefabs/Panel1",false	)
	obj.transform:SetParent(canvas.transform,false)
	Panel1.Start(obj.transform)
	-- local obj = UnityEngine.Resources.Load("UIPrefabs/Panel1") 
	-- print(obj)
	-- UnityEngine.GameObject.Instantiate(obj)
end


function Update()
	--调用Ctrl.lua中的Update方法
	--ctrl.Update()
end


