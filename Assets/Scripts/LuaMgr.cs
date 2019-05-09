using LuaInterface;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class LuaMgr : MonoBehaviour {
    private static LuaMgr _instance;
    public static LuaMgr Instance {
        get {
            if (null == _instance) {
                GameObject go = new GameObject();
                _instance = go.AddComponent <LuaMgr> ();
            }
            return _instance;
        }

    }

    public void Init() {
        Application.logMessageReceived += Log;
        luaEnv = new LuaState();
        luaEnv.Start();
        string lusPath = Application.dataPath + "/Scripts/LuaScripts";
        luaEnv.AddSearchPath(lusPath);
        luaEnv.DoFile("main.lua");
        //luaEnv.Require("main");
    }

    private void Log(string condition, string stackTrace, LogType type) {
        //Debug.Log(condition);
    }

    LuaState luaEnv;
    // Use this for initialization
    void Start () {

    }

    private void OnDestroy() {
        if (null != luaEnv) {
            luaEnv.Dispose();
            luaEnv = null;
        }
    }

}
