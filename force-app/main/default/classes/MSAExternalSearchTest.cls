/**
* @author Tcs
* @date 04/11/2022
* @group Vitality
*<Purpose>Test class for MSAExternalSearch </Purpose>
*/

@IsTest
public class MSAExternalSearchTest {

    /*testGetNonMedicalConditions*/
    @IsTest
    private static void testHealth() {

        Test.startTest();
        final DataSource.SearchContext context = new DataSource.SearchContext();
        final DataSource.TableSelection selectedTable = new DataSource.TableSelection();
        selectedTable.tableSelected = 'Health Condition';
        context.searchPhrase = '10005186';
        context.tableSelections = new List<DataSource.TableSelection>{selectedTable};
        MSAExternalSearch.getData(context);
        Test.stopTest();
        system.assertNotEquals(null,MSAExternalSearch.getData(context));
    }

}