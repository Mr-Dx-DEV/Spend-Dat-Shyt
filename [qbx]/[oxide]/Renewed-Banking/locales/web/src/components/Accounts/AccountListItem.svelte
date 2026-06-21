<script lang="ts">
    import { accounts, activeAccount, popupDetails, atm, translations } from "../../store/stores";
    import { formatMoney } from "../../utils/misc";
    export let account:any;

    function handleAccountClick(id: any) {
        activeAccount.update(() => id);
    };

    let isAtm: boolean;
    function handleButton(id:string, type:string) {
        let account = $accounts.find((accountItem: any) => id === accountItem.id);
        popupDetails.update(() => ({ actionType: type, account }));
    }

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

    atm.subscribe((usingAtm: boolean) => {
        isAtm = usingAtm;
    });
</script>

<section class="account" on:click={()=>handleAccountClick(account.id)} on:keydown={()=>{}}>
    <h4>
        {account.type}{$translations.account}/ {account.id}
    </h4>
    <h5>
        {account.type}{$translations.account}<br />
        <span>{account.name}</span>
    </h5>

    <div class="price">
        <strong>{formatMoney(account.amount)}</strong> <br />
        <span>{$translations.balance}</span>
    </div>

    {#if account.credit?.enabled}
        <div class="credit-summary">
            <span>
                <strong>{account.credit.score}</strong>
                {t("credit_score", "Credit Score")}
            </span>
            <span>
                <strong>{formatMoney(account.credit.maxLoan)}</strong>
                {t("loan_max_score", "Max by Score")}
            </span>
            <span>
                <strong>{formatMoney(account.credit.availableLoan)}</strong>
                {t("loan_available", "Available Loan")}
            </span>
            {#if account.credit.totalRemaining > 0}
                <span>
                    <strong>{formatMoney(account.credit.totalRemaining)}</strong>
                    {t("loan_balance", "Loan Balance")}
                </span>
            {/if}
            {#if account.credit.nextDueAt}
                <span>
                    <strong>{formatDate(account.credit.nextDueAt)}</strong>
                    {t("loan_due_date", "Payment Due")}
                </span>
            {/if}
            {#if account.credit.hasOverdue}
                <p class="credit-warning">
                    {t("loan_overdue_warning", "Overdue loan: credit score is dropping until paid.")}
                </p>
            {:else if !account.credit.canBorrow}
                <p class="credit-locked">
                    {account.credit.denialReason || t("loan_locked", "Loan option locked")}
                </p>
            {/if}
        </div>
    {/if}

    <div class="btns-group">
        {#if !(account.isFrozen || account.frozen)}
            {#if !isAtm}
                <button class="btn btn-green" on:click={() => handleButton(account.id, "deposit")}>{$translations.deposit_but}</button>
            {/if}
            <button class="btn btn-orange" on:click={() => handleButton(account.id, "withdraw")}>{$translations.withdraw_but}</button>
            <button class="btn btn-grey" on:click={() => handleButton(account.id, "transfer")}>{$translations.transfer_but}</button>
            {#if account.credit?.enabled && !isAtm}
                {#if account.credit.canBorrow}
                    <button class="btn btn-green" on:click={() => handleButton(account.id, "applyLoan")}>{t("apply_loan_but", "Apply Loan")}</button>
                {:else}
                    <button class="btn btn-grey" disabled>{t("loan_locked_but", "Loan Locked")}</button>
                {/if}
                {#if account.credit.totalRemaining > 0}
                    <button class="btn btn-orange" on:click={() => handleButton(account.id, "repayLoan")}>{t("repay_loan_but", "Repay Loan")}</button>
                {/if}
            {/if}
        {:else}
            {$translations.frozen}
        {/if}
    </div>
</section>

<style>
    .account {
        background-color: var(--clr-primary);
        padding: 1rem;
        border-radius: 10px;
        cursor: pointer;
        box-shadow: 3px 5px 37px 4px rgba(48,48,48,0.38);
        -webkit-box-shadow: 3px 5px 37px 4px rgba(48,48,48,0.38);
        -moz-box-shadow: 3px 5px 37px 4px rgba(48,48,48,0.38);
    }
    .account:not(:last-child) {
        margin-bottom: 1.5rem;
    }

    h4 {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
    }
    h5 {
        font-size: 1.2rem;
    }
    h5 span {
        margin-top: 0.3rem;
    }

    .price {
        text-align: right;
        margin-bottom: 1rem;
    }
    .price strong {
        font-size: 1.6rem;
    }

    .credit-summary {
        display: grid;
        grid-template-columns: 1fr;
        gap: 0.45rem;
        margin-bottom: 1rem;
        padding: 0.8rem;
        border-radius: 5px;
        background-color: rgba(255, 255, 255, 0.05);
        color: #ced3eb;
        font-size: 1.05rem;
    }

    .credit-summary span {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 0.8rem;
    }

    .credit-summary strong {
        color: #fff;
    }

    .credit-warning,
    .credit-locked {
        margin-top: 0.3rem;
        color: var(--clr-orange);
        line-height: 1.35;
    }

    .credit-locked {
        color: #B6BACF;
    }

    button:disabled {
        cursor: not-allowed;
        opacity: 0.55;
    }

    /* make first btn in btn-group take up the whole first row */
  .btns-group > :first-child {
    grid-column: 1 / -1;
  }
  .btns-group {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 0.5rem;
  }
</style>
