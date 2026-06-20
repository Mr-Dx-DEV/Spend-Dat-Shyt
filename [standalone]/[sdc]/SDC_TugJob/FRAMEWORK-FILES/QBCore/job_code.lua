-- Put these jobs into your qb-core/shared/jobs.lua

['tugjob'] = {
	label = 'Tug',
	defaultDuty = true,
	offDutyPay = false,
	grades = {
        ['0'] = {
            name = 'Operator',
            payment = 0
        }
    },
},