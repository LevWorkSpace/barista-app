public class GarbageCollector implements Schedulable {

    public void execute(SchedulableContext param1) {
        try {
            ArchivatorService.collectOld();
        } catch (Exception e) {
            TheMostAbstractUtility.logException('GarbageCollector', e);
            throw e;
        }
    }
}