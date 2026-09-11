# Primer

These scripts (`chtc-port`, `launch_job.sh`, and `submit_job.sub`) are set up to connect to CHTC and run a GUI locally.

To avoid constantly signing in follow the instructions [here](https://chtc.cs.wisc.edu/uw-research-computing/configure-ssh)

If you don't set up the persistent connection, expect to have to enter your password+duo push 8+ times.

**DO NOT FORGET TO `condor_rm <job_id>` WHEN YOU ARE DONE**


# Files and what they do
| File name | Function | 
| -------- | -------- | 
| `chtc-port`  | Job launching script that users execute from their local device  |
| `launch_job.sh`  | Job executable  |
| `submit_job.sub` | Job submission script |

**IF YOU CHANGE THE NAME OF `launch_job.sh` OR `submit_job.sub` YOU NEED TO CHANGE ALL INSTANCES OF THOSE FILES IN `chtc-port`**

# How to launch job on CHTC

### Download the `holder` directory onto your local device
```
# Navigate into the directory (local)
cd /path/to/holder/
```

### Edit `chtc-port`

Change line 27 and 28 in `chtc-port` to your specific `AP_HOST` and `AP_USER`

```
AP_HOST="${AP_HOST:-ap2001.chtc.wisc.edu}" #or ap2002.chtc.wisc.edu
AP_USER="your_netid" #${AP_USER:-${USER}}"
```

### Add your files

Add your files to line 170

```
scp -qr "$local_submit_file" "$local_launch_script" "${ap_host}:${remote_submit_dir}/" app.py
```

### Make executable
```
chmod +x chtc-port
```

### Run
On your local device, run the executable
```
./chtc-port
```

If you didn't specify your `AP_HOST` and `AP_USER` you can run
```
AP_HOST=ap2001.chtc.wisc.edu AP_USER=your_netid ./chtc-port
```

### Open GUI in browser (Streamlit example)
If streamlit runs successfully, you should see output like this
```
2026-08-05 17:29:37.758 Uvicorn server started on :::####

  You can now view your Streamlit app in your browser.

  Local URL: http://localhost:####
  Network URL: http://128.105.76.46:####
  External URL: http://128.105.76.46:####

==========================================

Copy the URL above and paste it in your browser to access streamlit

streamlit is running on the execution point. To connect interactively:
  ssh netid@ap2001.chtc.wisc.edu
  condor_ssh_to_job 9561998

To stop streamlit and clean up:
  ssh netid@ap2001.chtc.wisc.edu
  condor_rm 9561998

Press Ctrl+C to close this connection (streamlit will keep running)

Keeping port forwarding active...
If you need to resume, run:
  ./chtc-agents resume <job_id> ####
```

**Copy and paste `http://localhost:####` into your local browser**

### CONDOR_RM YOUR JOB WHEN YOU ARE DONE
```
# On CHTC terminal
condor_rm <job_id>
```