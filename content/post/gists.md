---
title: "配置云存儲 Github-Gists VSCode一鍵部署生產環境"
date: 2018-12-05
type: ["計算機"]
weight: 1
tags: ["計算機","github","vscode"]
thumbnail: "/pics/vscode/vscode.png"
draft: true
---
## 問題描述

- 擁有**不止一個生產環境**，而且這些生產環境也**不一定持久**的情況下（隨時有可能一鍵重裝、部署新機器），不同生產環境要求有相同的配置（同步需求）

- 有隨時隨地**看到好 extensions 就想 install 的壞習慣**

- 作為生產力工具，需要**快速、自動化、可管理的**部署以減少不必要損失（包括不限於擴展配置）

## 解決方案

使用較為小型的私人代碼在線託管服務（大型網路里專門用於管理配置的配置服務器），將配置代碼上傳託管，按需獲取。有安全需求可自建機器與認證。

### VSCode

VSCode 中有一個提供 Setting Sync Anywhere 的擴展，使用 Github 提供的 [Gists](http://gohom.win/2015/11/26/gist/) 服務

## 寫在最後
### 擴展推薦
### 其他