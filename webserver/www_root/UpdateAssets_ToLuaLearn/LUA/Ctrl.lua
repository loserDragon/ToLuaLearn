local music = require("Music")
local ctrl = {}
local cube
local GameObject = UnityEngine.GameObject
local force = 5
local Input = UnityEngine.Input
function ctrl.start()
    --查找Cube物体
    cube = GameObject.Find("Cube")
    --修改物体的材质求颜色
    cube:GetComponent("Renderer").material.color = Color(0.5,0,0.5,1)
    --添加AudioSource组件
    cube:AddComponent(typeof(UnityEngine.AudioSource))
    --加载音乐并播放，在另一个lua脚本里
    music.startCoroutine()

    --这个是演示使用event中封装的关于Update，Fixupdate等等方法中，Update方法的使用
    local parm = 0
    local handle = UpdateBeat:CreateListener(ctrl.TestUpdate, parm) --好像只支持一个参数 
    UpdateBeat:AddListener(handle)  
    --end
end

--cube控制的逻辑处理，是在update中执行的
function ctrl.Update()
    local h = Input.GetAxis("Horizontal")
    local v = Input.GetAxis("Vertical")
    if h ~=0 or v ~=0 then
        cube.transform.localPosition =cube.transform.localPosition +  Vector3(h, 0, v)*0.1
    end

end

--这个是演示使用event中封装的关于Update，Fixupdate等等方法中，Update方法的使用
function ctrl.TestUpdate()
    print(123)
end

return ctrl  


