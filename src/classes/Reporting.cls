public class Reporting implements Schedulable {

    private static final String TELEGRAM_API_URL = 'https://api.telegram.org/bot';
    private static final String TELEGRAM_COMMAND_SEND = '/sendMessage';
    private static final String TELEGRAM_MESSAGE_MOD = 'Markdown';
    private static final String REPORT_VARIABLE_SUM = '{sum}';
    private static final String REPORT_VARIABLE_HALF_SUM = '{sum/2}';
    private static final String REPORT_VARIABLE_7PERCENT_SUM = '{7}';
    private static final String REPORT_VARIABLE_7PERCENT_HALF_SUM = '{7/2}';

    public void execute(SchedulableContext param1) {
        try {

            Decimal dailyTotal = getDailyTotal();
            new TelegramTotalReporter().send(dailyTotal);
        } catch (Exception e) {
            saveLog('Reporting error: ' + e.getMessage());
        }
    }

    private class TelegramTotalReporter {
        private Decimal dailyTotal;
        private SensitiveConfigurations__c configuration;

        public TelegramTotalReporter() {
            configuration = [SELECT TelegramChannelId__c, TelegramToken__c, TelegramTemplateMessage__c
                            FROM SensitiveConfigurations__c
                            ORDER BY CreatedDate DESC
                            LIMIT 1];
        }

        public void send(Decimal dailyTotal) {
            TelegramMessage telegramMessage = buildTelegramMessage(dailyTotal);
            sendToTelegram(telegramMessage);
        }

        private TelegramMessage buildTelegramMessage(Decimal dailyTotal) {
            String message = configuration.TelegramTemplateMessage__c
                    .replace(REPORT_VARIABLE_HALF_SUM, (dailyTotal/2).format())
                    .replace(REPORT_VARIABLE_SUM, dailyTotal.format())
                    .replace(REPORT_VARIABLE_7PERCENT_HALF_SUM, (dailyTotal/2*0.07).format())
                    .replace(REPORT_VARIABLE_7PERCENT_SUM, (dailyTotal*0.07).format());

            TelegramMessage telegramMessage = new TelegramMessage();
            telegramMessage.text = message;
            telegramMessage.parse_mode = TELEGRAM_MESSAGE_MOD;
            telegramMessage.chat_id = configuration.TelegramChannelId__c;
            return TelegramMessage;
        }

        private void sendToTelegram(TelegramMessage telegramMessage) {
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setEndpoint(TELEGRAM_API_URL + configuration.TelegramToken__c + TELEGRAM_COMMAND_SEND);
            System.debug(TELEGRAM_API_URL + configuration.TelegramToken__c + TELEGRAM_COMMAND_SEND);
            request.setMethod('POST');
            System.debug(JSON.serialize(telegramMessage));
            request.setBody(JSON.serialize(telegramMessage));

            HttpResponse response = new Http().send(request);

            if (response.getStatusCode() != 200) {
                saveLog('Telegram error: ' + response.getStatusCode() + ' | ' + response.getStatus());
            }
        }
    }

    private static Decimal getDailyTotal() {
        AggregateResult result = [SELECT sum(TotalPriceWithDiscount__c) dailyTotal FROM Bill__c WHERE CreatedDate = TODAY];
        return (Decimal)result.get('dailyTotal');
    }

    @future
    private static void saveLog(String error) {
        insert new Log__c(Error__c = error);
    }

    private class TelegramMessage {
        public String chat_id;
        public String text;
        public String parse_mode;
    }
}