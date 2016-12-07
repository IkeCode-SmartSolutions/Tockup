package br.com.ikecode.tockup.SendMessage;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.loopj.android.http.JsonHttpResponseHandler;

import org.json.JSONArray;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import br.com.ikecode.tockup.MainActivity;
import br.com.ikecode.tockup.R;
import br.com.ikecode.tockup.adapters.GenericAdapter;
import br.com.ikecode.tockup.apiclient.TockUpApiClient;
import br.com.ikecode.tockup.models.SuffixCategory;
import cz.msebera.android.httpclient.Header;

public class SelectSuffixCategoryFragment extends Fragment {
    public SelectSuffixCategoryFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
        }
    }

    private ListView listView;
    private List<SuffixCategory> _original;
    public List<SuffixCategory> Filtered;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_generic_list_select, container, false);
        TextView title = (TextView)view.findViewById(R.id.txtGenericListHeader);
        title.setText("Selecione o prefixo da mensagem");

        this.Filtered = new ArrayList<>();

        final GenericAdapter<SuffixCategory> adapter = new GenericAdapter<>(getContext(), this.Filtered);

        listView = (ListView) view.findViewById(R.id.genericListView);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                SuffixCategory selected = (SuffixCategory)listView.getItemAtPosition(position);

                SelectMessageSuffixFragment fragment = new SelectMessageSuffixFragment();
                Bundle args = new Bundle();
                args.putInt(SelectMessageSuffixFragment.ARG_SUFFIX_CATEGORY_ID, selected.id);
                fragment.setArguments(args);

                FragmentManager fm = getFragmentManager();
                final FragmentTransaction ft = fm.beginTransaction();
                ft.replace(R.id.frame_container, fragment);
                ft.addToBackStack(null);
                ft.commit();
            }
        });

        View header = getActivity().getLayoutInflater().inflate(R.layout.listview_search_header, null);
        listView.addHeaderView(header);

        listView.setAdapter(adapter);

        final MainActivity activity = (MainActivity) getActivity();
        activity.ToggleProgressBar(true);
        TockUpApiClient.get("suffixcategory/", null, new JsonHttpResponseHandler(){
            @Override
            public void onSuccess(int statusCode, Header[] headers, JSONArray response) {
                // Pull out the first event on the public timeline
                GsonBuilder builder = TockUpApiClient.GetGsonBuilder();

                Gson gson = builder.create();
                Type listType = new TypeToken<List<SuffixCategory>>(){}.getType();
                List<SuffixCategory> objList = gson.fromJson(response.toString(), listType);
                _original = objList;

                activity.ToggleProgressBar(false);
                adapter.Update(objList);
            }
        });

        EditText txtContactFilter = (EditText) header.findViewById(R.id.txtListViewSearchHeader);
        txtContactFilter.setHint("pesquise por nome");
        txtContactFilter.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {}

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {}

            @Override
            public void afterTextChanged(Editable editable) {
                String text = editable.toString();
                if (text.length() > 1) {
                    Filtered = new ArrayList<>();

                    for (int i = 0; i < _original.toArray().length; i++) {
                        SuffixCategory obj = (SuffixCategory) _original.toArray()[i];
                        if (obj.name.toLowerCase().contains(text.toLowerCase())) {
                            Filtered.add(obj);
                        }
                    }
                } else {
                    Filtered = _original;
                }

                adapter.Update(Filtered);
            }
        });

        // Inflate the layout for this fragment
        return view;
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
    }

    @Override
    public void onDetach() {
        super.onDetach();
    }
}