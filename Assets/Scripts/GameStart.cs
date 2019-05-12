using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameStart : MonoBehaviour {

    //资源服务器地址
    private string serverUrl = "http://127.0.0.1:6080/UpdateAssets/";

    // Use this for initialization
    void Start () {
        //LuaMgr.Instance.Init();
        Debuger.EnableOnScreen(true);
    }
	
}
