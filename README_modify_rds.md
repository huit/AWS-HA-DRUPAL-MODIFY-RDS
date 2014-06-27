AWS RDS DB Instance Modify
==================================

Welcome to the HUIT Infrastructure AWS RDS DB Instance Modify Utility


## Quickstart

To use this utility, refer to help method within utility by running the following:


```
$> ./modify_rds.sh -h
```

$ modify_mysql_rds.sh -h
Usage: aws rds modify-db-instance --db-instance-identifier <DBInstanceIdentifier> --<PARAM> <VALUE> --<PARAM> <VALUE> ...

where DBInstanceIdentifier is the identifier assigned to the instance by AWS,
where PARAM is one of the following:

db-security-groups
vpc-security-group-ids
apply-immediately
allow-major-version-upgrade
master-user-password
backup-retention-period
new-db-instance-identifier
auto-minor-version-upgrade
engine-version
multi-az
iops
preferred-maintenance-window
allocated-storage
db-instance-class
preferred-backup-window
option-group-name
db-parameter-group-name

and VALUE is set via environment variable where
environment variable name is PARAM with spaces omitted,
e.g. export dbinstanceclass=db.m1.large

NOTE: if --apply-immediate is omitted, any change requiring an outage will take
effect during the next scheduled maintenance window.

To apply a change immediately set environment variable applyimmediately=true

You can also review the list of RDS instance parameters which can be set by running helper tool:

```
$> ./bin/find_cf_params ./resources/modify_rds.json
```

The helper tool needs python 2.7 (which is also a requirement for the AWS cli tools)

## Details

As stated, to run the utility you must set first set DBInstanceIdentifier=<DB Instance Identifier as listed in AWS> together with 
one or more instance parameters as described above.





