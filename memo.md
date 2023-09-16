# 作業用メモ

- agentの初期設定 ( `[INFO]  systemd: Starting k3s-agent` ) が終わらなかった時に調査したこと</br></br>

  - 状態を確認する。([github](https://github.com/k3s-io/k3s/issues/8179))

    ```sh
    sudo journalctl -u k3s-agent --no-pager &> /host_synced/k3s.log
    ```

  - agentからserverへ接続できるか確認する。([github](https://github.com/k3s-io/k3s/issues/2852))

    ```sh
    curl -vk https://10.0.2.101:6443
    ```
