#include "../src/RecordLoader.h"
#include "../src/BitmapIterator.h"
#include "../src/BitmapConstructor.h"
#include <time.h>
#include <iostream>
using namespace std;
// $.categoryPath[1:3].id
string query(BitmapIterator* iter) {
    string output = "";
    if (iter->isObject() && iter->moveToKey("categoryPath")) {
        if (iter->down() == false) return output; /* value of "categoryPath" */
        if (iter->isArray()) {
            for (int idx = 1; idx <= 2; ++idx) {
                // 2nd and 3rd elements inside "categoryPath" array
                if (iter->moveToIndex(idx)) {
                    if (iter->down() == false) continue;
                    if (iter->isObject() && iter->moveToKey("id")) {
                        // value of "id"
                        char* value = iter->getValue();
                        output.append(value).append(";");
                        if (value) free(value);
                    }
                    iter->up();
                }
            }
        }
        iter->up();
    }
    return output;
}

int main(int argc, char* argv[]) {
    clock_t tStart = clock();
    char* file_path = "../test_dataset/bestbuy_large_record.json";
    RecordSet* record_set = RecordLoader::loadRecords(file_path);
    if (record_set->size() == 0) {
        cout<<"record loading fails."<<endl;
        return -1;
    }
    string output = "";

    // set the number of threads for parallel bitmap construction
    int thread_num = 1;
    if (argc==1){
    cout<<"No args passed : default threads is set to 1"<<endl;
    }
    if (argc>=2){
    	thread_num = atoi(argv[1]);
    	cout<<"threads is set to "<<thread_num<<endl;
    }

    /* set the number of levels of bitmaps to create, either based on the
     * query or the JSON records. E.g., query $[*].user.id needs three levels
     * (level 0, 1, 2), but the record may be of more than three levels
     */
    int level_num = 3;

    /* process the records one by one: for each one, first build bitmap, then perform
     * the query with a bitmap iterator
     */
    int num_recs = record_set->size();
    Bitmap* bm = NULL;
    for (int i = 0; i < num_recs; i++) {
        bm = BitmapConstructor::construct((*record_set)[i], thread_num, level_num);
        BitmapIterator* iter = BitmapConstructor::getIterator(bm);
        output.append(query(iter));
        delete iter;
    }
    delete bm;
    delete record_set;

    //cout<<"matches are: "<<output<<endl;
    cout<<"Threads used: "<<thread_num<<endl;
    cout<<"Dataset: "<<file_path<<endl;
    cout<<"Time taken: "<<(double)(clock() - tStart)/CLOCKS_PER_SEC<<endl;
    return 0;
}