<script lang="ts">
    import { accounts, popupDetails, loading, translations } from "../store/stores";
    import {fetchNui} from "../utils/fetchNui"
    import { formatMoney } from "../utils/misc";
    let amount: number = 0;
    let comment: string = "";
    let stateid: string = "";
    $: actionType = $popupDetails.actionType;
    $: isLoanAction = actionType === "applyLoan" || actionType === "repayLoan";
    $: credit = $popupDetails.account.credit || {};
    $: canSubmit = !(actionType === "applyLoan" && credit.enabled && !credit.canBorrow);

    function t(key: string, fallback: string) {
        return ($translations && $translations[key]) || fallback;
    }

    function formatDate(seconds: number) {
        if (!seconds) return t("loan_no_due_date", "No due date");
        return new Date(seconds * 1000).toLocaleDateString("en-US", {
            month: "short",
            day: "numeric",
            hour: "numeric",
            minute: "2-digit"
        });
    }

    function closePopup() {
        popupDetails.update((val: any) => ({
            ...val,
            actionType: ""
        }));
    }

    function submitInput() {
        loading.set(true);
        const payload = isLoanAction
            ? { amount: amount, comment: comment }
            : { fromAccount: $popupDetails.account.id, amount: amount, comment: comment, stateid: stateid };

        if (!canSubmit) {
            loading.set(false);
            return;
        }

        fetchNui($popupDetails.actionType, payload).then(retData => {
            setTimeout(() => {
                if (retData !== false){
                    accounts.set(retData);
                }
                loading.set(false);
            }, 1000);
        })
        amount = 0;
        comment = "";
        stateid = "";
        closePopup();
    }

    function getTitle() {
        if (actionType === "applyLoan") return t("loan_apply_title", "Apply for Loan");
        if (actionType === "repayLoan") return t("loan_repay_title", "Repay Loan");
        return `${$popupDetails.account.type}${$translations.account}/ ${$popupDetails.account.id}`;
    }
</script>

<section class="popup-container">
    <section class="popup-content">
        <h2>{getTitle()}</h2>
        {#if isLoanAction && credit.enabled}
            <div class="loan-summary">
                <span>{t("credit_score", "Credit Score")} <strong>{credit.score}</strong></span>
                <span>{t("loan_max_score", "Max by Score")} <strong>{formatMoney(credit.maxLoan)}</strong></span>
                <span>{t("loan_available", "Available Loan")} <strong>{formatMoney(credit.availableLoan)}</strong></span>
                <span>{t("loan_interest", "Interest Rate")} <strong>{credit.interestRate}%</strong></span>
                <span>{t("loan_balance", "Loan Balance")} <strong>{formatMoney(credit.totalRemaining)}</strong></span>
                {#if credit.nextDueAt}
                    <span>{t("loan_due_date", "Payment Due")} <strong>{formatDate(credit.nextDueAt)}</strong></span>
                {/if}
            </div>
            {#if actionType === "applyLoan" && !credit.canBorrow}
                <div class="loan-status locked">
                    <strong>{t("loan_denied", "Loan Denied")}</strong>
                    <span>{credit.denialReason || t("loan_locked", "Loan option locked")}</span>
                </div>
            {/if}
            {#if credit.hasOverdue}
                <div class="loan-status overdue">
                    <strong>{t("loan_overdue", "Loan Overdue")}</strong>
                    <span>{t("loan_overdue_warning", "Overdue loan: credit score is dropping until paid.")}</span>
                    <span>{t("loan_credit_lost", "Credit Lost")}: {credit.overdueCreditLoss}</span>
                    <span>-{credit.overduePenaltyPoints} / {credit.overduePenaltyIntervalHours}h</span>
                </div>
            {/if}
        {/if}
        <form action="#">
            <div class="form-row">
                <label for="amount">{actionType === "repayLoan" ? t("repay_amount", "Repay Amount") : $translations.amount}</label>
                <input bind:value={amount} type="number" name="amount" id="amount" placeholder="$" disabled={!canSubmit} />
            </div>

            <div class="form-row">
                <label for="comment">{$translations.comment}</label>
                <input bind:value={comment} type="text" name="comment" id="comment" placeholder="//" />
            </div>

            {#if $popupDetails.actionType === "transfer"}
                <div class="form-row">
                    <label for="stateId">{$translations.transfer}</label>
                    <input bind:value={stateid} type="text" name="stateId" id="stateId" placeholder="#" />
                </div>
            {/if}

            {#if actionType === "repayLoan" && credit.loans?.length > 0}
                <div class="loan-list">
                    {#each credit.loans as loan (loan.loan_id)}
                        <div class:overdueLoan={loan.is_overdue}>
                            <span>
                                <strong>{formatMoney(loan.remaining)}</strong>
                                {loan.status?.toUpperCase()} / {loan.interest_rate}%
                            </span>
                            <span>
                                {t("loan_due_date", "Payment Due")}
                                <strong>{formatDate(loan.due_at)}</strong>
                            </span>
                            {#if loan.is_overdue}
                                <span>
                                    {t("loan_overdue_days", "Overdue Days")}
                                    <strong>{loan.overdue_days}</strong>
                                </span>
                                <span>
                                    {t("loan_credit_lost", "Credit Lost")}
                                    <strong>{loan.credit_lost}</strong>
                                </span>
                            {/if}
                        </div>
                    {/each}
                </div>
            {/if}

            <div class="btns-group">
                <button type="button" class="btn btn-orange" on:click={closePopup}>{$translations.cancel}</button>
                <button type="button" class="btn btn-green" disabled={!canSubmit} on:click={() => submitInput()}>{$translations.confirm}</button>
            </div>
        </form>
    </section>
</section>

<style>
    .popup-container {
        position: fixed;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        background-color: rgba(255, 255, 255, 0.3);

        display: flex;
        align-items: center;
        justify-content: center;
    }

    .popup-content {
        max-width: 60rem;
        width: 100%;
        background-color: var(--clr-primary);
        padding: 5rem;
        border-radius: 1rem;
    }

    h2 {
        margin-bottom: 3rem;
        text-align: center;
        font-size: 2rem;
    }

    .loan-summary,
    .loan-list,
    .loan-status {
        display: grid;
        gap: 0.8rem;
        margin-bottom: 2rem;
        padding: 1rem;
        border-radius: 5px;
        background-color: #2a2b33;
        color: #B6BACF;
    }

    .loan-summary span,
    .loan-list span {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
        font-size: 1.2rem;
    }

    .loan-summary strong,
    .loan-list strong {
        color: #fff;
    }

    .loan-status {
        border: 1px solid var(--clr-orange);
        color: #fff;
    }

    .loan-status.locked {
        border-color: var(--clr-grey);
        color: #B6BACF;
    }

    .loan-list > div {
        display: grid;
        gap: 0.5rem;
        padding: 0.8rem;
        border-radius: 5px;
        background-color: rgba(255, 255, 255, 0.04);
    }

    .loan-list > div.overdueLoan {
        border: 1px solid var(--clr-orange);
    }

    .form-row {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        color: #F3F4F5;
        margin-bottom: 2rem;
    }
    .form-row label,
    .form-row input {
        font-size: 1.4rem;
        color: inherit;
    }

    .form-row input {
        width: 100%;
        border-radius: 5px;
        background-color: transparent;
        border: none;
        padding: 1.4rem;
        margin-bottom: 1rem;
        background-color: #2a2b33;
        color: #fff; 
    }

    button:disabled,
    input:disabled {
        cursor: not-allowed;
        opacity: 0.55;
    }
</style>
