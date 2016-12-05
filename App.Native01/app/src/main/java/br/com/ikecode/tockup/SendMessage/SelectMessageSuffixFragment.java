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
import br.com.ikecode.tockup.models.MessageSuffix;
import cz.msebera.android.httpclient.Header;

public class SelectMessageSuffixFragment extends Fragment {
    public static final String ARG_SUFFIX_CATEGORY_ID = "SuffixCategoryId";
    private int suffixCategoryId;

    public SelectMessageSuffixFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            suffixCategoryId = getArguments().getInt(ARG_SUFFIX_CATEGORY_ID);
        }
    }

    private ListView listView;
    private List<MessageSuffix> _original;
    public List<MessageSuffix> Filtered;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_generic_list_select, container, false);
        TextView title = (TextView)view.findViewById(R.id.txtGenericListHeader);
        title.setText("Selecione o prefixo da mensagem");

        this.Filtered = new ArrayList<>();

        final GenericAdapter<MessageSuffix> adapter = new GenericAdapter<>(getContext(), this.Filtered);

        final MainActivity activity = (MainActivity)getActivity();

        listView = (ListView) view.findViewById(R.id.prefixListView);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                MessageSuffix selected = (MessageSuffix)listView.getItemAtPosition(position);
                activity.message.selectedSuffix = selected;

                MessageSummaryFragment fragment = new MessageSummaryFragment();
                FragmentManager fm = getFragmentManager();
                final FragmentTransaction ft = fm.beginTransaction();
                ft.replace(R.id.frame_container, fragment);
                ft.addToBackStack(null);
                ft.commit();
            }
        });

        View header = activity.getLayoutInflater().inflate(R.layout.listview_header_row, null);
        listView.addHeaderView(header);

        listView.setAdapter(adapter);

        if(this.suffixCategoryId > 0) {
            TockUpApiClient.get("messagesuffix/" + this.suffixCategoryId, null, new JsonHttpResponseHandler() {
                @Override
                public void onSuccess(int statusCode, Header[] headers, JSONArray response) {
                    // Pull out the first event on the public timeline
                    GsonBuilder builder = TockUpApiClient.GetGsonBuilder();

                    Gson gson = builder.create();
                    Type listType = new TypeToken<List<MessageSuffix>>() {
                    }.getType();
                    List<MessageSuffix> objList = gson.fromJson(response.toString(), listType);
                    _original = objList;
                    adapter.Update(objList);
                }
            });
        }

        final EditText txtContactFilter = (EditText) header.findViewById(R.id.txtContactFilter);
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
                    String[] words = text.split(" ");
                    if(words.length > 0) {

                    }
                    Filtered = new ArrayList<>();

                    for (int i = 0; i < _original.toArray().length; i++) {
                        MessageSuffix obj = (MessageSuffix) _original.toArray()[i];
                        if (obj.name.toLowerCase().contains(text.toLowerCase())) {
                            Filtered.add(obj);
                        }
                    }
                } else {
                    Filtered = _original;
                }

                adapter.Update(Filtered);
                txtContactFilter.requestFocus();
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
