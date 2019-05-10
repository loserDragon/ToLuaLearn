/***
 * 
 *    Title: 框架模块
 *           主题：      基于Resources的资源加载管理 
 *    Description: 
 *           功能： 
 *                  
 *    Date: 
 *    Version: 0.1版本
 *    Modify Recoder: 
 *    Author: 
 *   
 */
using UnityEngine;
using System;
using System.Collections;



    public class ResourcesMgr  {
        /* 字段 */
        private Hashtable ht = null;                        //容器键值对集合

       public ResourcesMgr() {
            ht = new Hashtable();
        }


        /// <summary>
        /// 调用资源（带对象缓冲技术）
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="path"></param>
        /// <param name="isCatch"></param>
        /// <returns></returns>
        public T LoadResource<T>(string path, bool isCatch) where T : UnityEngine.Object {
            if (ht.Contains(path)) {
                return ht[path] as T;
            }

            T TResource = Resources.Load<T>(path);
            if (TResource == null) {
                Debug.LogError(GetType() + "/GetInstance()/TResource 提取的资源找不到，请检查。 path=" + path);
            }
            else if (isCatch) {
                ht.Add(path, TResource);
            }

            return TResource;
        }

        /// <summary>
        /// 调用资源（带对象缓冲技术）
        /// </summary>
        /// <param name="path"></param>
        /// <param name="isCatch"></param>
        /// <returns></returns>
        public GameObject LoadAsset(string path, bool isCatch) {
            GameObject goObj = LoadResource<GameObject>(path, isCatch);
            if (null == goObj) {
                Debug.LogError(GetType() + "/LoadAsset()/加载资源不成功，请检查。 path=" + path);
                return null;
            }
            GameObject goObjClone = GameObject.Instantiate<GameObject>(goObj);
            if (goObjClone == null) {
                Debug.LogError(GetType() + "/LoadAsset()/克隆资源不成功，请检查。 path=" + path);
            }
            //goObj = null;//??????????
            return goObjClone;
        }

        /// <summary>
        /// 加载路径下的所有资源（不带对象缓冲技术）
        /// </summary>
        /// <param name="path"></param>
        /// <param name="isCatch"></param>
        /// <returns></returns>
        public T[] LoadAllAsset<T>(string path) where T:UnityEngine.Object{
            if (string.IsNullOrEmpty(path)) {
                Debug.LogError(GetType() + "/LoadAllAsset()/加载资源失败，请检查。 path=" + path);
                return null;
            }
           T[] _T = Resources.LoadAll<T>(path);
           return _T;
        }

 

    }//Class_end
                                      