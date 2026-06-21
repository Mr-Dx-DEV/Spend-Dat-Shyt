-- Put these jobs into your qbx-core/shared/jobs.lua

['ccjob'] = {
	label = 'Car Crushers',
	defaultDuty = true,
	offDutyPay = false,
	grades = {
        ['0'] = {
            name = 'Operator',
            payment = 0
        }
    },
},