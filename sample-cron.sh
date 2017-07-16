if [[ -f /usr/src/app/myscript.running ]] ; then
    echo "Script already running. Please do not execute it again until previous instance finish"
    exit
fi
# Add lock file to ensure process is not running twice
touch /usr/src/app/myscript.running
# Python Process  (one for each customer)
# Customer ECI
#mkdir -p /usr/src/app/journal_ECI/{txt_gz,txt,csv,csv_gz}
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
python /usr/src/app/mail_journal.py -Fu:ibm2hawthorn@elcorteingles.es -Fp:S1lverst0ne -Du:silverstone -Dp:UKGrandPr1x! -Dt:Journal_ECI -Cfg:/usr/src/app/mail_journal.cfg >> /usr/src/app/journal_ECI/ECI-mail_journal.log.$current_time
# Remove lock file. 
rm /usr/src/app/myscript.running
