using LuaInterface;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LuaMgr : MonoBehaviour {

    //虚拟机对象
    LuaState luaEnv;
    //保存lua中要执行的方法
    LuaFunction luaFunc;
    //是否执行update方法
    private bool isExeUpdate = false;

    private static LuaMgr _instance;
    public  static LuaMgr Instance {
        get {
            if (null == _instance)
                _instance = new GameObject("LuaMgr").AddComponent<LuaMgr>();

            return _instance;
        }
    }

    protected  void Awake() {
        //Instance = this;
//#if UNITY_5_4_OR_NEWER
//        SceneManager.sceneLoaded += OnSceneLoaded;
//#endif  
    }

    public void StartLua() {
        Init();
    }
    //初始化方法
    protected   void Init() {
        //创建虚拟机
        luaEnv = new LuaState();
        luaEnv.OpenLibs(LuaDLL.luaopen_pb);
        //启动虚拟机
        luaEnv.Start();
        //委托工厂初始化
        DelegateFactory.Init();
        //绑定C#中，unity中的方法给lua使用，少了这一句，在lua中无法使用，Unity的API
        LuaBinder.Bind(luaEnv);
        //执行lua协同要先有这个组件
        LuaLooper lusLoop = gameObject.AddComponent<LuaLooper>();
        //指定虚拟机
        lusLoop.luaState = luaEnv;

        Debug.Log("###################"+PathTools.GetPackerABPath());
        luaEnv.AddSearchPath(PathTools.GetPackerABPath()+"/LUA");
        luaEnv.AddSearchPath(PathTools.GetPackerABPath() + "/LUA/lua");

        //加载lua的入口文件
        luaEnv.DoFile("Main.lua");
        //执行入口函数 ,封装的方法
        LuaCallFunc("Main",gameObject);
        //启动update
        isExeUpdate = true;

    }


    private void Update() {
        if (isExeUpdate) {
            //执行main.lua中的Update方法，lua中要一直执行的方法，放到 main.lua的Update就行了，就跟这里的Update一样
            //tolua中在tolua/lua下有个event.lua这里也有处理Update，Fixupdate的方法
            //原理也跟我这一样，只不过他做了更深层的封装，他其实是在 LuaLooper中执行的相应脚本中的Update
            LuaCallFunc("Update",gameObject);
        }                       

    }

    private void OnDestroy() {
        if (null != luaEnv) {
            luaEnv.Dispose();
            luaEnv = null;
        }
    }

    /// <summary>
    /// 调用lua中的方法
    /// </summary>
    /// <param name="funcName">方法名</param>
    /// <param name="obj">参数(可不传)</param>
    public void LuaCallFunc(string funcName,GameObject obj) {
        //获取方法
        luaFunc = luaEnv.GetFunction(funcName);
        //执行方法
        luaFunc.Call(obj);
        //释放
        luaFunc.Dispose();
        luaFunc = null;
    }

}
