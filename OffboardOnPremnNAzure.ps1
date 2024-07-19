















function FWR-Verify($attribute,$optional){
    #Confirm $attribute
    for($i=0;$i -lt 1;){ 
        $value = read-host("`nEnter the " + $attribute + $optional)
        $verify = Read-Host ("Is "+"'"+ $value +"'" + " correct? (Y/N)" )
        if(($verify -eq "Y") -or ($verify -eq "y")){
            $value
            $i=1 
        }
        elseif(($verify -eq "N") -or ($verify -eq "n")){
            continue
        }
    } 
}

function FWR-ValidAdUser {
    for($i=0;$i -lt 1;){
        try{
        $SAM = FWR-Verify("user to offboard")
        $UserExists = Get-ADUser -Identity $SAM
        $i=1 
        }
        catch{
            Write-Host "User not found, please try again!"
        }
    }   
    $UserExists
}


function FWR-GetGroups($user2offboard){
    $groups = (Get-ADUser $user2offboard -Properties MemberOf | Select-Object -ExpandProperty MemberOf | Get-ADGroup | Select-Object Name).Name
    Write-Host "On-Prem groups to be removed" -BackgroundColor red
    
    foreach($group in $groups){
        if($group -eq 'Business Premium'){
            Write-Host $group -BackgroundColor Red
        }
        else {
            Write-Host $group
        }
         
      
    }

}

#----------(END)----------


$user2offboard = FWR-ValidAdUser
FWR-GetGroups($user2offboard)

##  Set-RemoteMailbox <MailboxIdentity> -Type <Regular | Shared | Room | Equipment>