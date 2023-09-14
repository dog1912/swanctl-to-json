#!/bin/sh

start=$(swanctl --stats --raw)
workers_total=$( echo $start |awk -F '=' '{print $4}' | grep -oE "[0-9]{1,5}")
workers_idle=$(echo $start |awk -F '=' '{print $5}' | grep -oE "[0-9]{1,5}")
workers_active_critical=$(echo $start |awk -F '=' '{print $6}' | grep -oE "[0-9]{1,5}")
workers_active_high=$(echo $start |awk -F '=' '{print $7}' | grep -oE "[0-9]{1,5}")
workers_active_medium=$(echo $start |awk -F '=' '{print $8}' | grep -oE "[0-9]{1,5}")
workers_active_low=$(echo $start |awk -F '=' '{print $9}' | grep -oE "[0-9]{1,5}")
queues_critical=$(echo $start |awk -F '=' '{print $10}' | grep -oE "[0-9]{1,5}")
queues_high=$(echo $start |awk -F '=' '{print $11}' | grep -oE "[0-9]{1,5}")
queues_medium=$(echo $start |awk -F '=' '{print $12}' | grep -oE "[0-9]{1,5}")
queues_low=$(echo $start |awk -F '=' '{print $13}' | grep -oE "[0-9]{1,5}")
scheduled=$(echo $start |awk -F '=' '{print $14}' | grep -oE "[0-9]{1,5}")
ikesas_total=$(echo $start |awk -F '=' '{print $15}' | grep -oE "[0-9]{1,5}")
ikesas_half_open=$(echo $start |awk -F '=' '{print $16}' | grep -oE "[0-9]{1,5}")

echo '{
      "workers": {
        "total": '$workers_total',
        "idle": '$workers_idle',
        "active": {
          "critical": '$workers_active_critical',
          "high": '$workers_active_high',
          "medium": '$workers_active_medium',
          "low": '$workers_active_low'
        }
      },
      "queues": {
        "critical": '$queues_critical',
        "high": '$queues_high',
        "medium": '$queues_medium',
        "low": '$queues_low'
      },
      "scheduled": '$scheduled',
      "ikesas": {
        "total": '$ikesas_total',
        "half-open": '$ikesas_half_open'
      }
}'
