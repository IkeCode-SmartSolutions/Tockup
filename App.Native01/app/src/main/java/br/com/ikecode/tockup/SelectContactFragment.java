package br.com.ikecode.tockup;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.ActionBar;
import android.support.v7.widget.Toolbar;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.JsonHttpResponseHandler;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import br.com.ikecode.tockup.SendMessage.SelectPrefixCategoryFragment;
import br.com.ikecode.tockup.apiclient.TockUpApiClient;
import cz.msebera.android.httpclient.Header;

import org.json.*;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link SelectContactFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class SelectContactFragment extends Fragment {
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    //private static final String ARG_PARAM1 = "param1";

    //private String mParam1;

    public SelectContactFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @return A new instance of fragment SelectContactFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static SelectContactFragment newInstance(String param1) {
        SelectContactFragment fragment = new SelectContactFragment();
        Bundle args = new Bundle();
        //args.putString(ARG_PARAM1, param1);
        fragment.setArguments(args);
        return fragment;
    }

    private ListView listView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            //mParam1 = getArguments().getString(ARG_PARAM1);
        }
    }

    private List<Contact> _originalContacts;
    public List<Contact> FilteredContacts;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View selectContactFragment = inflater.inflate(R.layout.fragment_select_contact, container, false);

        this.FilteredContacts = new ArrayList<>();

        final ContactAdapter adapter = new ContactAdapter(getContext(), R.layout.listview_item_row, this.FilteredContacts);

        listView = (ListView) selectContactFragment.findViewById(R.id.listView);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Contact listItem = (Contact)listView.getItemAtPosition(position);

                SelectPrefixCategoryFragment fragment = new SelectPrefixCategoryFragment();
                FragmentManager fm = getFragmentManager();
                final FragmentTransaction ft = fm.beginTransaction();
                ft.replace(R.id.frame_container, fragment);
                ft.addToBackStack(null);
                ActionBar ab = ((MainActivity)getActivity()).getSupportActionBar();
                ft.commit();
            }
        });

        View header = getActivity().getLayoutInflater().inflate(R.layout.listview_header_row, null);
        listView.addHeaderView(header);

        listView.setAdapter(adapter);

        TockUpApiClient.get("user/all", null, new JsonHttpResponseHandler(){
            @Override
            public void onSuccess(int statusCode, Header[] headers, JSONArray users) {
                // Pull out the first event on the public timeline
                Gson gson = new Gson();
                Type listType = new TypeToken<List<Contact>>(){}.getType();
                List<Contact> contacts = gson.fromJson(users.toString(), listType);
                _originalContacts = contacts;
                adapter.Update(_originalContacts);
            }
        });

        EditText txtContactFilter = (EditText) header.findViewById(R.id.txtContactFilter);
        txtContactFilter.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {}

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {}

            @Override
            public void afterTextChanged(Editable editable) {
                String text = editable.toString();
                if (text.length() > 1) {
                    FilteredContacts = new ArrayList<>();

                    for (int i = 0; i < _originalContacts.toArray().length; i++) {
                        Contact obj = (Contact)_originalContacts.toArray()[i];
                        if (obj.fullName.toLowerCase().contains(text.toLowerCase())
                                || obj.phoneNumber.toLowerCase().contains(text.toLowerCase())) {
                            FilteredContacts.add(obj);
                        }
                    }
                } else {
                    FilteredContacts = _originalContacts;
                }

                adapter.Update(FilteredContacts);
            }
        });

        // Inflate the layout for this fragment
        return selectContactFragment;
    }
}