-- Put these jobs into your qb-core/shared/jobs.lua

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