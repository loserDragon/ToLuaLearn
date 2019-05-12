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

function Init1()
	local res =  ResourcesMgr.New()
	canvas =  res:LoadAsset("Canvas",false	)
	UnityEngine.GameObject.Find("InitPanel"):SetActive(false)
	SUIFW.ABMgr.Instance():LoadAssetBundlePack("uiprefabs", "uiprefabs/uiprefabs.ab",Callback)
end

function Callback(abName)
	local tmp = SUIFW.ABMgr.Instance():LoadAsset("uiprefabs", "uiprefabs/uiprefabs.ab", "Panel1.prefab", false);
		if tmp then
			local obj =  UnityEngine.GameObject.Instantiate(tmp)
			obj.transform:SetParent(canvas.transform,false)
			Panel1.Start(obj.transform)
		end
end

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


